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
  });
}
