import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/local/audio_storage/drift/database.dart';
import 'package:front/data/local/audio_storage/drift/drift_audio_storage.dart';
import 'package:front/data/remote/api/vk_api_client.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftAudioStorage', () {
    late AppDatabase database;
    late DriftAudioStorage storage;

    setUp(() {
      // Используем in-memory базу данных для тестов
      final connection = DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      );
      database = AppDatabase(connection);
      storage = DriftAudioStorage(database);
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'Should save and retrieve complete VkAudioTrack with all nested entities',
      () async {
        // Создаем тестовые данные с полной структурой
        const thumb = VkThumb(
          width: 300,
          height: 300,
          id: 'thumb_123',
          photo34: 'photo34_url',
          photo135: 'photo135_url',
          photo300: 'photo300_url',
          photo600: 'photo600_url',
        );

        const album = VkAlbum(
          id: 456,
          title: 'Test Album',
          ownerId: 789,
          mainColor: '#FF0000',
          thumb: thumb,
        );

        const mainArtist = VkMainArtist(
          name: 'Test Artist',
          domain: 'test_artist',
          id: 'artist_123',
        );

        const track = VkAudioTrack(
          id: 123,
          ownerId: 456,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
          date: 1640995200,
          genreId: 1,
          lyricsId: 2,
          album: album,
          mainArtists: [mainArtist],
        );

        final tracks = IList([track]);

        // Сохраняем треки
        await storage.updateTracks(tracks);

        // Получаем треки обратно
        final retrievedTracks = await storage.getTracks();

        // Проверяем что получили полную структуру
        expect(retrievedTracks.length, equals(1));

        final retrievedTrack = retrievedTracks.first;
        expect(retrievedTrack.id, equals(123));
        expect(retrievedTrack.ownerId, equals(456));
        expect(retrievedTrack.title, equals('Test Track'));
        expect(retrievedTrack.artist, equals('Test Artist'));
        expect(retrievedTrack.duration, equals(180));
        expect(retrievedTrack.url, equals('https://example.com/track.mp3'));
        expect(retrievedTrack.date, equals(1640995200));
        expect(retrievedTrack.genreId, equals(1));
        expect(retrievedTrack.lyricsId, equals(2));

        // Проверяем альбом
        expect(retrievedTrack.album, isNotNull);
        expect(retrievedTrack.album!.id, equals(456));
        expect(retrievedTrack.album!.title, equals('Test Album'));
        expect(retrievedTrack.album!.ownerId, equals(789));
        expect(retrievedTrack.album!.mainColor, equals('#FF0000'));

        // Проверяем thumb альбома
        expect(retrievedTrack.album!.thumb, isNotNull);
        expect(retrievedTrack.album!.thumb!.width, equals(300));
        expect(retrievedTrack.album!.thumb!.height, equals(300));
        expect(retrievedTrack.album!.thumb!.id, equals('thumb_123'));
        expect(retrievedTrack.album!.thumb!.photo34, equals('photo34_url'));
        expect(retrievedTrack.album!.thumb!.photo135, equals('photo135_url'));
        expect(retrievedTrack.album!.thumb!.photo300, equals('photo300_url'));
        expect(retrievedTrack.album!.thumb!.photo600, equals('photo600_url'));

        // Проверяем main artists
        expect(retrievedTrack.mainArtists, isNotNull);
        expect(retrievedTrack.mainArtists!.length, equals(1));
        expect(retrievedTrack.mainArtists!.first.name, equals('Test Artist'));
        expect(retrievedTrack.mainArtists!.first.domain, equals('test_artist'));
        expect(retrievedTrack.mainArtists!.first.id, equals('artist_123'));
      },
    );

    test('Should handle tracks without optional fields', () async {
      const track = VkAudioTrack(
        id: 123,
        ownerId: 456,
        title: 'Simple Track',
        artist: 'Simple Artist',
        duration: 120,
        url: 'https://example.com/simple.mp3',
      );

      final tracks = IList([track]);

      await storage.updateTracks(tracks);
      final retrievedTracks = await storage.getTracks();

      expect(retrievedTracks.length, equals(1));

      final retrievedTrack = retrievedTracks.first;
      expect(retrievedTrack.id, equals(123));
      expect(retrievedTrack.title, equals('Simple Track'));
      expect(retrievedTrack.album, isNull);
      expect(retrievedTrack.mainArtists, isNull);
    });

    test('Should update existing tracks when calling updateTracks', () async {
      // Первый набор треков
      const track1 = VkAudioTrack(
        id: 123,
        ownerId: 456,
        title: 'Original Track',
        artist: 'Original Artist',
        duration: 180,
        url: 'https://example.com/original.mp3',
      );

      await storage.updateTracks(IList([track1]));

      // Обновленный набор треков
      const track2 = VkAudioTrack(
        id: 123,
        ownerId: 456,
        title: 'Updated Track',
        artist: 'Updated Artist',
        duration: 200,
        url: 'https://example.com/updated.mpk',
      );

      await storage.updateTracks(IList([track2]));

      final retrievedTracks = await storage.getTracks();

      expect(retrievedTracks.length, equals(1));
      expect(retrievedTracks.first.title, equals('Updated Track'));
      expect(retrievedTracks.first.artist, equals('Updated Artist'));
      expect(retrievedTracks.first.duration, equals(200));
    });

    test(
      'Should implement cascade update - keep existing tracks, update specified ones, add new ones',
      () async {
        // Исходные треки: 1, 2, 3
        final initialTracks = [
          const VkAudioTrack(
            id: 1,
            ownerId: 100,
            title: 'Track 1',
            artist: 'Artist 1',
            duration: 120,
            url: 'https://example.com/track1.mp3',
          ),
          const VkAudioTrack(
            id: 2,
            ownerId: 100,
            title: 'Track 2',
            artist: 'Artist 2',
            duration: 180,
            url: 'https://example.com/track2.mp3',
          ),
          const VkAudioTrack(
            id: 3,
            ownerId: 100,
            title: 'Track 3',
            artist: 'Artist 3',
            duration: 200,
            url: 'https://example.com/track3.mp3',
          ),
        ];

        await storage.updateTracks(IList(initialTracks));

        // Проверяем что все треки сохранены
        final tracksAfterFirstUpdate = await storage.getTracks();
        expect(tracksAfterFirstUpdate.length, equals(3));

        // Обновляем с треками: 3 (обновленный), 4 (новый), 5 (новый)
        final updatedTracks = [
          const VkAudioTrack(
            id: 3,
            ownerId: 100,
            title: 'Track 3 Updated',
            artist: 'Artist 3 Updated',
            duration: 250,
            url: 'https://example.com/track3_updated.mp3',
          ),
          const VkAudioTrack(
            id: 4,
            ownerId: 100,
            title: 'Track 4',
            artist: 'Artist 4',
            duration: 150,
            url: 'https://example.com/track4.mp3',
          ),
          const VkAudioTrack(
            id: 5,
            ownerId: 100,
            title: 'Track 5',
            artist: 'Artist 5',
            duration: 300,
            url: 'https://example.com/track5.mp3',
          ),
        ];

        await storage.updateTracks(IList(updatedTracks));

        // Проверяем результат: должны быть треки 1, 2, 3 (обновленный), 4, 5
        final finalTracks = await storage.getTracks();

        expect(finalTracks.length, equals(5));

        // Проверяем что треки 1 и 2 не изменились
        final track1 = finalTracks.firstWhere((t) => t.id == 1);
        expect(track1.title, equals('Track 1'));
        expect(track1.artist, equals('Artist 1'));

        final track2 = finalTracks.firstWhere((t) => t.id == 2);
        expect(track2.title, equals('Track 2'));
        expect(track2.artist, equals('Artist 2'));

        // Проверяем что трек 3 обновился
        final track3 = finalTracks.firstWhere((t) => t.id == 3);
        expect(track3.title, equals('Track 3 Updated'));
        expect(track3.artist, equals('Artist 3 Updated'));
        expect(track3.duration, equals(250));

        // Проверяем что треки 4 и 5 добавились
        final track4 = finalTracks.firstWhere((t) => t.id == 4);
        expect(track4.title, equals('Track 4'));
        expect(track4.artist, equals('Artist 4'));

        final track5 = finalTracks.firstWhere((t) => t.id == 5);
        expect(track5.title, equals('Track 5'));
        expect(track5.artist, equals('Artist 5'));
      },
    );

    test('Should delete all tracks', () async {
      const track = VkAudioTrack(
        id: 123,
        ownerId: 456,
        title: 'Test Track',
        artist: 'Test Artist',
        duration: 180,
        url: 'https://example.com/track.mp3',
      );

      await storage.updateTracks(IList([track]));

      // Проверяем что треки сохранены
      final tracksBefore = await storage.getTracks();
      expect(tracksBefore.length, equals(1));

      // Удаляем все треки
      await storage.deleteAllTracks();

      // Проверяем что треки удалены
      final tracksAfter = await storage.getTracks();
      expect(tracksAfter.length, equals(0));
    });

    group('Unavailable tracks functionality', () {
      test('Should mark track as unavailable', () async {
        // Изначально трек не должен быть недоступным
        final isUnavailable = await storage.isTrackUnavailable(123, 456);
        expect(isUnavailable, isFalse);

        // Помечаем трек как недоступный
        await storage.markTrackAsUnavailable(123, 456, '123_456');

        // Проверяем что трек стал недоступным
        final isUnavailableAfter = await storage.isTrackUnavailable(123, 456);
        expect(isUnavailableAfter, isTrue);
      });

      test('Should not duplicate unavailable track', () async {
        // Помечаем трек как недоступный первый раз
        await storage.markTrackAsUnavailable(123, 456, '123_456');

        // Помечаем тот же трек как недоступный второй раз
        await storage.markTrackAsUnavailable(123, 456, '123_456');

        // Получаем список недоступных треков
        final unavailableTracks = await storage.getUnavailableTracks();
        expect(unavailableTracks.length, equals(1));

        final track = unavailableTracks.first;
        expect(track.id, equals(123));
        expect(track.ownerId, equals(456));
        expect(track.fullId, equals('123_456'));
      });

      test('Should get correct count of unavailable tracks', () async {
        // Изначально должно быть 0 недоступных треков
        final initialCount = await storage.getUnavailableTracksCount();
        expect(initialCount, equals(0));

        // Добавляем несколько недоступных треков
        await storage.markTrackAsUnavailable(123, 456, '123_456');
        await storage.markTrackAsUnavailable(789, 101, '789_101');
        await storage.markTrackAsUnavailable(202, 303, '202_303');

        // Проверяем количество
        final finalCount = await storage.getUnavailableTracksCount();
        expect(finalCount, equals(3));
      });

      test('Should get list of unavailable tracks', () async {
        // Добавляем недоступные треки
        await storage.markTrackAsUnavailable(123, 456, '123_456');
        await storage.markTrackAsUnavailable(789, 101, '789_101');

        // Получаем список
        final unavailableTracks = await storage.getUnavailableTracks();
        expect(unavailableTracks.length, equals(2));

        // Проверяем первый трек
        final firstTrack = unavailableTracks.firstWhere((t) => t.id == 123);
        expect(firstTrack.ownerId, equals(456));
        expect(firstTrack.fullId, equals('123_456'));

        // Проверяем второй трек
        final secondTrack = unavailableTracks.firstWhere((t) => t.id == 789);
        expect(secondTrack.ownerId, equals(101));
        expect(secondTrack.fullId, equals('789_101'));
      });

      test('Should clear unavailable tracks', () async {
        // Добавляем недоступные треки
        await storage.markTrackAsUnavailable(123, 456, '123_456');
        await storage.markTrackAsUnavailable(789, 101, '789_101');

        // Проверяем что они есть
        final countBefore = await storage.getUnavailableTracksCount();
        expect(countBefore, equals(2));

        // Очищаем список
        await storage.clearUnavailableTracks();

        // Проверяем что список пуст
        final countAfter = await storage.getUnavailableTracksCount();
        expect(countAfter, equals(0));

        // Проверяем что конкретный трек больше не недоступен
        final isUnavailable = await storage.isTrackUnavailable(123, 456);
        expect(isUnavailable, isFalse);
      });

      test(
        'Should handle different tracks with same ID but different owner',
        () async {
          // Добавляем треки с одинаковым ID но разными владельцами
          await storage.markTrackAsUnavailable(123, 456, '123_456');
          await storage.markTrackAsUnavailable(123, 789, '123_789');

          // Проверяем что оба трека недоступны
          final isUnavailable1 = await storage.isTrackUnavailable(123, 456);
          final isUnavailable2 = await storage.isTrackUnavailable(123, 789);
          expect(isUnavailable1, isTrue);
          expect(isUnavailable2, isTrue);

          // Проверяем общее количество
          final count = await storage.getUnavailableTracksCount();
          expect(count, equals(2));
        },
      );
    });

    group('Cached artists functionality', () {
      test('Should save and retrieve cached artist', () async {
        final artist = VkArtist(
          id: 123,
          name: 'Test Artist',
          domain: 'test_artist',
          photo: 'https://example.com/photo.jpg',
        );

        // Сохраняем артиста в кеш
        await storage.saveCachedArtist(artist, '123');

        // Получаем артиста из кеша
        final cachedArtist = await storage.getCachedArtist('123');

        expect(cachedArtist, isNotNull);
        expect(cachedArtist!.id, equals('123'.hashCode));
        expect(cachedArtist.name, equals('Test Artist'));
        expect(cachedArtist.domain, equals('test_artist'));
        expect(cachedArtist.photo, equals('https://example.com/photo.jpg'));
      });

      test('Should return null for non-existent cached artist', () async {
        final cachedArtist = await storage.getCachedArtist('non_existent');
        expect(cachedArtist, isNull);
      });

      test('Should update existing cached artist', () async {
        final artist1 = VkArtist(
          id: 123,
          name: 'Original Artist',
          domain: 'original_artist',
          photo: 'https://example.com/photo1.jpg',
        );

        final artist2 = VkArtist(
          id: 123,
          name: 'Updated Artist',
          domain: 'updated_artist',
          photo: 'https://example.com/photo2.jpg',
        );

        // Сохраняем первого артиста
        await storage.saveCachedArtist(artist1, '123');

        // Обновляем артиста
        await storage.saveCachedArtist(artist2, '123');

        // Получаем обновленного артиста
        final cachedArtist = await storage.getCachedArtist('123');

        expect(cachedArtist, isNotNull);
        expect(cachedArtist!.name, equals('Updated Artist'));
        expect(cachedArtist.domain, equals('updated_artist'));
        expect(cachedArtist.photo, equals('https://example.com/photo2.jpg'));
      });

      test('Should get all cached artists', () async {
        final artist1 = VkArtist(
          id: 123,
          name: 'Artist 1',
          domain: 'artist1',
          photo: 'https://example.com/photo1.jpg',
        );

        final artist2 = VkArtist(
          id: 456,
          name: 'Artist 2',
          domain: 'artist2',
          photo: 'https://example.com/photo2.jpg',
        );

        final artist3 = VkArtist(
          id: 789,
          name: 'Artist 3',
          domain: null,
          photo: null,
        );

        // Сохраняем артистов
        await storage.saveCachedArtist(artist1, '123');
        await storage.saveCachedArtist(artist2, '456');
        await storage.saveCachedArtist(artist3, '789');

        // Получаем всех артистов
        final allArtists = await storage.getAllCachedArtists();

        expect(allArtists.length, equals(3));

        // Проверяем первого артиста
        final cachedArtist1 = allArtists.firstWhere(
          (a) => a.id == '123'.hashCode,
        );
        expect(cachedArtist1.name, equals('Artist 1'));
        expect(cachedArtist1.domain, equals('artist1'));
        expect(cachedArtist1.photo, equals('https://example.com/photo1.jpg'));

        // Проверяем второго артиста
        final cachedArtist2 = allArtists.firstWhere(
          (a) => a.id == '456'.hashCode,
        );
        expect(cachedArtist2.name, equals('Artist 2'));
        expect(cachedArtist2.domain, equals('artist2'));
        expect(cachedArtist2.photo, equals('https://example.com/photo2.jpg'));

        // Проверяем третьего артиста (без фото и домена)
        final cachedArtist3 = allArtists.firstWhere(
          (a) => a.id == '789'.hashCode,
        );
        expect(cachedArtist3.name, equals('Artist 3'));
        expect(cachedArtist3.domain, isNull);
        expect(cachedArtist3.photo, isNull);
      });

      test('Should check if artist photo was checked', () async {
        final artist = VkArtist(
          id: 123,
          name: 'Test Artist',
          domain: 'test_artist',
          photo: 'https://example.com/photo.jpg',
        );

        // Изначально артист не проверен
        final isCheckedBefore = await storage.isArtistPhotoChecked('123');
        expect(isCheckedBefore, isFalse);

        // Сохраняем артиста (это автоматически помечает его как проверенного)
        await storage.saveCachedArtist(artist, '123');

        // Теперь артист проверен
        final isCheckedAfter = await storage.isArtistPhotoChecked('123');
        expect(isCheckedAfter, isTrue);
      });

      test('Should mark artist as photo checked', () async {
        // Изначально артист не проверен
        final isCheckedBefore = await storage.isArtistPhotoChecked('123');
        expect(isCheckedBefore, isFalse);

        // Помечаем артиста как проверенного
        await storage.markArtistPhotoChecked('123', true);

        // Проверяем что артист помечен как проверенный
        final isCheckedAfter = await storage.isArtistPhotoChecked('123');
        expect(isCheckedAfter, isTrue);
      });

      test('Should mark artist as photo checked when not in cache', () async {
        // Помечаем несуществующего артиста как проверенного
        await storage.markArtistPhotoChecked('new_artist', false);

        // Проверяем что артист создан и помечен как проверенный
        final isChecked = await storage.isArtistPhotoChecked('new_artist');
        expect(isChecked, isTrue);

        // Проверяем что артист создан в кеше
        final cachedArtist = await storage.getCachedArtist('new_artist');
        expect(cachedArtist, isNotNull);
        expect(cachedArtist!.name, equals('')); // Пустое имя для нового артиста
      });

      test('Should get artists to update', () async {
        // Создаем треки с артистами
        const track1 = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Track 1',
          artist: 'Artist 1',
          duration: 120,
          url: 'https://example.com/track1.mp3',
          mainArtists: [
            VkMainArtist(name: 'Artist 1', domain: 'artist1', id: 'artist_1'),
            VkMainArtist(name: 'Artist 2', domain: 'artist2', id: 'artist_2'),
          ],
        );

        const track2 = VkAudioTrack(
          id: 2,
          ownerId: 100,
          title: 'Track 2',
          artist: 'Artist 3',
          duration: 180,
          url: 'https://example.com/track2.mp3',
          mainArtists: [
            VkMainArtist(name: 'Artist 2', domain: 'artist2', id: 'artist_2'),
            VkMainArtist(name: 'Artist 3', domain: 'artist3', id: 'artist_3'),
          ],
        );

        await storage.updateTracks(IList([track1, track2]));

        // Изначально все артисты должны быть в списке для обновления
        final artistsToUpdate = await storage.getArtistsToUpdate();
        expect(artistsToUpdate.length, equals(3));
        expect(artistsToUpdate.contains('artist_1'), isTrue);
        expect(artistsToUpdate.contains('artist_2'), isTrue);
        expect(artistsToUpdate.contains('artist_3'), isTrue);

        // Проверяем что все артисты изначально в списке для обновления
        expect(artistsToUpdate.length, equals(3));
        expect(artistsToUpdate.contains('artist_1'), isTrue);
        expect(artistsToUpdate.contains('artist_2'), isTrue);
        expect(artistsToUpdate.contains('artist_3'), isTrue);
      });

      test('Should handle empty artists to update', () async {
        // Если нет треков, список должен быть пуст
        final artistsToUpdate = await storage.getArtistsToUpdate();
        expect(artistsToUpdate.length, equals(0));
      });

      test('Should handle tracks without main artists', () async {
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Track without artists',
          artist: 'Simple Artist',
          duration: 120,
          url: 'https://example.com/track.mp3',
        );

        await storage.updateTracks(IList([track]));

        // Если нет main artists, список должен быть пуст
        final artistsToUpdate = await storage.getArtistsToUpdate();
        expect(artistsToUpdate.length, equals(0));
      });
    });
  });
}
