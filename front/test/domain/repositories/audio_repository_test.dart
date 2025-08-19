import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/local/audio_storage/audio_storage.dart';
import 'package:front/data/remote/api/track_sessions_client.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/data/remote/services/vk_service.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'audio_repository_test.mocks.dart';

// Dummy объект для тестов
final _dummyArtist = VkArtist(id: 0, name: 'dummy', domain: null, photo: null);

@GenerateMocks([VkService, AudioStorage, TrackSessionsClient])
void main() {
  group('AudioRepository', () {
    late MockVkService mockVkService;
    late MockAudioStorage mockAudioStorage;
    late MockTrackSessionsClient mockSessionsClient;
    late AudioRepository audioRepository;

    setUp(() {
      mockVkService = MockVkService();
      mockAudioStorage = MockAudioStorage();
      mockSessionsClient = MockTrackSessionsClient();
      audioRepository = AudioRepository(
        mockVkService,
        mockAudioStorage,
        mockSessionsClient,
      );
    });

    group('getAudioData', () {
      test('Should filter out unavailable tracks from missing IDs', () async {
        // Подготавливаем тестовые данные
        const localTrack = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Local Track',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );

        final sessions = [
          const TrackSession(
            fullId: '2_200', // Нужно загрузить
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
          const TrackSession(
            fullId: '3_300', // Недоступный трек
            firstObserved: 1640995320,
            lastSeen: 1640995380,
          ),
        ];

        const missingTrack = VkAudioTrack(
          id: 2,
          ownerId: 200,
          title: 'Missing Track',
          artist: 'Artist B',
          duration: 200,
          url: 'https://example.com/track2.mp3',
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([localTrack]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);

        // Настраиваем проверку недоступных треков
        when(
          mockAudioStorage.isTrackUnavailable(2, 200),
        ).thenAnswer((_) async => false); // 2_200 доступен в базе
        when(
          mockAudioStorage.isTrackUnavailable(3, 300),
        ).thenAnswer((_) async => true); // 3_300 недоступен в базе

        when(
          mockVkService.getAudioById(const IListConst(['2_200'])),
        ).thenAnswer(
          (_) async => VkAudioResult(
            tracks: const IListConst([]), // 2_200 недоступен в API
            errors: IListConst([VkAudioUnavailableException('2_200')]),
          ),
        );
        when(
          mockAudioStorage.updateTracks(IListConst([missingTrack])),
        ).thenAnswer((_) async {});

        // Вызываем метод - теперь он не выбрасывает исключение для недоступных треков
        final (tracks, resultSessions) = await audioRepository.getAudioData();

        // Проверяем что недоступные треки отфильтрованы
        expect(
          tracks.length,
          equals(1),
        ); // localTrack (2_200 недоступен в API, 3_300 недоступен в базе)
        expect(resultSessions.length, equals(2)); // все сессии

        // Проверяем что недоступный трек не был запрошен
        verify(
          mockVkService.getAudioById(const IListConst(['2_200'])),
        ).called(1);
      });

      test(
        'Should handle VkAudioUnavailableException and mark tracks as unavailable',
        () async {
          // Подготавливаем тестовые данные
          const localTrack = VkAudioTrack(
            id: 1,
            ownerId: 100,
            title: 'Local Track',
            artist: 'Artist A',
            duration: 180,
            url: 'https://example.com/track1.mp3',
          );

          final sessions = [
            const TrackSession(
              fullId: '2_200',
              firstObserved: 1640995260,
              lastSeen: 1640995320,
            ),
          ];

          // Настраиваем моки
          when(
            mockAudioStorage.getTracks(),
          ).thenAnswer((_) async => IListConst([localTrack]));
          when(
            mockSessionsClient.getSessions(),
          ).thenAnswer((_) async => sessions);
          when(
            mockAudioStorage.isTrackUnavailable(2, 200),
          ).thenAnswer((_) async => false); // 2_200 доступен в базе
          when(
            mockAudioStorage.markTrackAsUnavailable(2, 200, '2_200'),
          ).thenAnswer((_) async {});

          when(
            mockVkService.getAudioById(const IListConst(['2_200'])),
          ).thenAnswer(
            (_) async => VkAudioResult(
              tracks: const IListConst([]), // 2_200 недоступен в API
              errors: IListConst([VkAudioUnavailableException('2_200')]),
            ),
          );

          // Вызываем метод
          final (tracks, resultSessions) = await audioRepository.getAudioData();

          // Проверяем что недоступный трек помечен как недоступный
          expect(tracks.length, equals(1)); // только localTrack
          expect(resultSessions.length, equals(1)); // все сессии

          // Проверяем что markTrackAsUnavailable был вызван
          verify(
            mockAudioStorage.markTrackAsUnavailable(2, 200, '2_200'),
          ).called(1);
        },
      );

      test(
        'Should handle mixed VkAudioUnavailableException and AppException',
        () async {
          // Подготавливаем тестовые данные
          const localTrack = VkAudioTrack(
            id: 1,
            ownerId: 100,
            title: 'Local Track',
            artist: 'Artist A',
            duration: 180,
            url: 'https://example.com/track1.mp3',
          );

          final sessions = [
            const TrackSession(
              fullId: '2_200',
              firstObserved: 1640995260,
              lastSeen: 1640995320,
            ),
            const TrackSession(
              fullId: '3_300',
              firstObserved: 1640995260,
              lastSeen: 1640995320,
            ),
          ];

          // Настраиваем моки
          when(
            mockAudioStorage.getTracks(),
          ).thenAnswer((_) async => IListConst([localTrack]));
          when(
            mockSessionsClient.getSessions(),
          ).thenAnswer((_) async => sessions);
          when(
            mockAudioStorage.isTrackUnavailable(2, 200),
          ).thenAnswer((_) async => false);
          when(
            mockAudioStorage.isTrackUnavailable(3, 300),
          ).thenAnswer((_) async => false);
          when(
            mockAudioStorage.markTrackAsUnavailable(2, 200, '2_200'),
          ).thenAnswer((_) async {});

          when(
            mockVkService.getAudioById(const IListConst(['2_200', '3_300'])),
          ).thenAnswer(
            (_) async => VkAudioResult(
              tracks: const IListConst([]),
              errors: IListConst([
                VkAudioUnavailableException('2_200'), // недоступен
                AppException('Network error for 3_300'), // сетевые ошибки
              ]),
              errorMessage: 'Network error',
            ),
          );

          // Вызываем метод - ожидаем исключение из-за AppException
          expect(
            () => audioRepository.getAudioData(),
            throwsA(isA<AppException>()),
          );
        },
      );

      test('Should return local tracks when no missing IDs', () async {
        // Подготавливаем тестовые данные
        const localTrack = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Local Track',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );

        final sessions = <TrackSession>[];

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IList([localTrack]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);

        // Вызываем метод
        final (tracks, resultSessions) = await audioRepository.getAudioData();

        // Проверяем результаты
        expect(tracks.length, equals(1));
        expect(resultSessions.length, equals(0));

        // Проверяем что API не вызывался
        verifyNever(mockVkService.getAudioById(any));
      });

      test('Should handle invalid fullId format', () async {
        // Подготавливаем тестовые данные
        const localTrack = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Local Track',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );

        final sessions = [
          const TrackSession(
            fullId: 'invalid_format', // Неверный формат
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
        ];

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IList([localTrack]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);
        when(
          mockVkService.getAudioById(const IListConst(['invalid_format'])),
        ).thenAnswer(
          (_) async => VkAudioResult(
            tracks: const IListConst([]),
            errors: IList([
              AppException('Ошибка загрузки аудио: invalid_format'),
            ]),
            errorMessage: 'Invalid format',
          ),
        );

        // Вызываем метод - ожидаем исключение из-за AppException
        expect(
          () => audioRepository.getAudioData(),
          throwsA(isA<AppException>()),
        );
      });

      test('Should handle sessions with non-matching track IDs', () async {
        // Подготавливаем тестовые данные
        const localTrack = VkAudioTrack(
          id: 456242588,
          ownerId: 18173818,
          title: 'Local Track',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );

        final sessions = [
          const TrackSession(
            fullId: '18173818_456242588', // Совпадает с localTrack
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
          const TrackSession(
            fullId: '18173818_456242589', // НЕ совпадает - нет такого трека
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
          const TrackSession(
            fullId: '99999999_123456789', // Совсем другой ownerId
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
        ];

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([localTrack]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);
        when(
          mockAudioStorage.isTrackUnavailable(18173818, 456242589),
        ).thenAnswer((_) async => false);
        when(
          mockAudioStorage.isTrackUnavailable(99999999, 123456789),
        ).thenAnswer((_) async => false);

        // Симулируем успешную загрузку треков из VK API
        when(
          mockVkService.getAudioById(
            const IListConst(['18173818_456242589', '99999999_123456789']),
          ),
        ).thenAnswer(
          (_) async => VkAudioResult(
            tracks: const IListConst([]), // Треки недоступны
            errors: IListConst([
              VkAudioUnavailableException('18173818_456242589'),
              VkAudioUnavailableException('99999999_123456789'),
            ]),
          ),
        );

        // Вызываем метод
        final (tracks, resultSessions) = await audioRepository.getAudioData();

        // Проверяем что возвращается только localTrack
        expect(tracks.length, equals(1));
        expect(tracks.first.fullId, equals('18173818_456242588'));

        // Проверяем что все сессии возвращаются
        expect(resultSessions.length, equals(3));

        // Проверяем что недоступные треки помечены как недоступные
        verify(
          mockAudioStorage.markTrackAsUnavailable(
            18173818,
            456242589,
            '18173818_456242589',
          ),
        ).called(1);
        verify(
          mockAudioStorage.markTrackAsUnavailable(
            99999999,
            123456789,
            '99999999_123456789',
          ),
        ).called(1);
      });

      test('Should handle empty sessions list', () async {
        // Подготавливаем тестовые данные
        const localTrack = VkAudioTrack(
          id: 456242588,
          ownerId: 18173818,
          title: 'Local Track',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );

        final sessions = <TrackSession>[];

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([localTrack]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);

        // Вызываем метод
        final (tracks, resultSessions) = await audioRepository.getAudioData();

        // Проверяем что возвращается localTrack
        expect(tracks.length, equals(1));
        expect(tracks.first.fullId, equals('18173818_456242588'));

        // Проверяем что сессии пустые
        expect(resultSessions.length, equals(0));

        // Проверяем что API не вызывался
        verifyNever(mockVkService.getAudioById(any));
      });

      test('Should handle all sessions matching local tracks', () async {
        // Подготавливаем тестовые данные
        const localTrack1 = VkAudioTrack(
          id: 456242588,
          ownerId: 18173818,
          title: 'Local Track 1',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );
        const localTrack2 = VkAudioTrack(
          id: 456242589,
          ownerId: 18173818,
          title: 'Local Track 2',
          artist: 'Artist B',
          duration: 200,
          url: 'https://example.com/track2.mp3',
        );

        final sessions = [
          const TrackSession(
            fullId: '18173818_456242588',
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
          const TrackSession(
            fullId: '18173818_456242589',
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
        ];

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([localTrack1, localTrack2]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);

        // Вызываем метод
        final (tracks, resultSessions) = await audioRepository.getAudioData();

        // Проверяем что возвращаются все треки
        expect(tracks.length, equals(2));
        expect(
          tracks.map((t) => t.fullId).toSet(),
          equals({'18173818_456242588', '18173818_456242589'}),
        );

        // Проверяем что все сессии возвращаются
        expect(resultSessions.length, equals(2));

        // Проверяем что API не вызывался (все треки уже есть локально)
        verifyNever(mockVkService.getAudioById(any));
      });
    });

    group('getListenedAudio', () {
      test('Should return tracks from getAudioData', () async {
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IList([track]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => <TrackSession>[]);

        // Вызываем метод
        final result = await audioRepository.getListenedAudio();

        // Проверяем результат
        expect(result.length, equals(1));
        expect(result.first, equals(track));
      });
    });

    group('getSessions', () {
      test('Should return sessions from getAudioData', () async {
        // Подготавливаем тестовые данные
        const localTrack = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Local Track',
          artist: 'Artist A',
          duration: 180,
          url: 'https://example.com/track1.mp3',
        );

        final sessions = [
          const TrackSession(
            fullId: '1_100',
            firstObserved: 1640995260,
            lastSeen: 1640995320,
          ),
        ];

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IList([localTrack]));
        when(
          mockSessionsClient.getSessions(),
        ).thenAnswer((_) async => sessions);
        when(
          mockAudioStorage.isTrackUnavailable(1, 100),
        ).thenAnswer((_) async => false);
        when(
          mockVkService.getAudioById(const IListConst(['1_100'])),
        ).thenAnswer(
          (_) async => VkAudioResult(
            tracks: const IListConst([]),
            errors: const IListConst([]),
          ),
        );

        // Вызываем метод
        final result = await audioRepository.getSessions();

        // Проверяем результат
        expect(result.length, equals(1));
        expect(result.first.fullId, equals('1_100'));
      });
    });

    test('Should handle NoTokenException and rethrow it', () async {
      // Подготавливаем тестовые данные
      const localTrack = VkAudioTrack(
        id: 1,
        ownerId: 100,
        title: 'Local Track',
        artist: 'Artist A',
        duration: 180,
        url: 'https://example.com/track1.mp3',
      );

      final sessions = [
        const TrackSession(
          fullId: '2_200',
          firstObserved: 1640995260,
          lastSeen: 1640995320,
        ),
      ];

      // Настраиваем моки
      when(
        mockAudioStorage.getTracks(),
      ).thenAnswer((_) async => IListConst([localTrack]));
      when(mockSessionsClient.getSessions()).thenAnswer((_) async => sessions);
      when(
        mockAudioStorage.isTrackUnavailable(2, 200),
      ).thenAnswer((_) async => false);

      // Симулируем NoTokenException в VkService
      when(
        mockVkService.getAudioById(const IListConst(['2_200'])),
      ).thenThrow(const NoTokenException());

      // Вызываем метод - ожидаем NoTokenException
      expect(
        () => audioRepository.getAudioData(),
        throwsA(isA<NoTokenException>()),
      );
    });

    group('getArtistsWithPhotos', () {
      test('Should return cached artists when available', () async {
        // Подготавливаем тестовые данные
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
          mainArtists: [
            VkMainArtist(name: 'Artist 1', domain: 'artist1', id: 'artist_1'),
          ],
        );

        final cachedArtist = VkArtist(
          id: 1,
          name: 'Artist 1',
          domain: 'artist1',
          photo: 'https://example.com/photo1.jpg',
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([track]));
        when(
          mockAudioStorage.getCachedArtist('artist_1'),
        ).thenAnswer((_) async => cachedArtist);

        // Вызываем метод
        final result = await audioRepository.getArtistsWithPhotos();

        // Проверяем результат
        expect(result.length, equals(1));
        expect(result.first.id, equals(1));
        expect(result.first.name, equals('Artist 1'));
        expect(result.first.photo, equals('https://example.com/photo1.jpg'));

        // Проверяем что не было вызовов к VK API
        verifyNever(mockVkService.getArtistById(any));
      });

      test(
        'Should load artist from VK API when not cached and not checked',
        () async {
          // Подготавливаем тестовые данные
          const track = VkAudioTrack(
            id: 1,
            ownerId: 100,
            title: 'Test Track',
            artist: 'Test Artist',
            duration: 180,
            url: 'https://example.com/track.mp3',
            mainArtists: [
              VkMainArtist(name: 'Artist 1', domain: 'artist1', id: 'artist_1'),
            ],
          );

          const artistInfo = VkArtistInfo(
            id: 'artist_1',
            name: 'Artist 1',
            domain: 'artist1',
            photos: [
              VkArtistPhoto(
                type: 'crop',
                photo: [
                  VkArtistPhotoSize(
                    url: 'https://example.com/photo1.jpg',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ],
          );

          final expectedArtist = VkArtist(
            id: 1,
            name: 'Artist 1',
            domain: 'artist1',
            photo: 'https://example.com/photo1.jpg',
          );

          // Настраиваем моки
          when(
            mockAudioStorage.getTracks(),
          ).thenAnswer((_) async => IListConst([track]));
          when(
            mockAudioStorage.getCachedArtist('artist_1'),
          ).thenAnswer((_) async => null);
          when(
            mockAudioStorage.isArtistPhotoChecked('artist_1'),
          ).thenAnswer((_) async => false);
          when(
            mockVkService.getArtistById('artist_1'),
          ).thenAnswer((_) async => artistInfo);
          when(
            mockAudioStorage.saveCachedArtist(_dummyArtist),
          ).thenAnswer((_) async {});

          // Вызываем метод
          final result = await audioRepository.getArtistsWithPhotos();

          // Проверяем результат
          expect(result.length, equals(1));
          expect(result.first.id, equals(1));
          expect(result.first.name, equals('Artist 1'));
          expect(result.first.photo, equals('https://example.com/photo1.jpg'));

          // Проверяем что артист был сохранен в кеш
          verify(mockAudioStorage.saveCachedArtist(_dummyArtist)).called(1);
        },
      );

      test('Should create artist without photo when already checked', () async {
        // Подготавливаем тестовые данные
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
          mainArtists: [
            VkMainArtist(name: 'Artist 1', domain: 'artist1', id: 'artist_1'),
          ],
        );

        final expectedArtist = VkArtist(
          id: 1,
          name: 'Artist 1',
          domain: 'artist1',
          photo: null,
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([track]));
        when(
          mockAudioStorage.getCachedArtist('artist_1'),
        ).thenAnswer((_) async => null);
        when(
          mockAudioStorage.isArtistPhotoChecked('artist_1'),
        ).thenAnswer((_) async => true);

        // Вызываем метод
        final result = await audioRepository.getArtistsWithPhotos();

        // Проверяем результат
        expect(result.length, equals(1));
        expect(result.first.id, equals(1));
        expect(result.first.name, equals('Artist 1'));
        expect(result.first.photo, isNull);

        // Проверяем что не было вызовов к VK API
        verifyNever(mockVkService.getArtistById(any));
      });

      test('Should handle API errors gracefully', () async {
        // Подготавливаем тестовые данные
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
          mainArtists: [
            VkMainArtist(name: 'Artist 1', domain: 'artist1', id: 'artist_1'),
          ],
        );

        final expectedArtist = VkArtist(
          id: 1,
          name: 'Artist 1',
          domain: 'artist1',
          photo: null,
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([track]));
        when(
          mockAudioStorage.getCachedArtist('artist_1'),
        ).thenAnswer((_) async => null);
        when(
          mockAudioStorage.isArtistPhotoChecked('artist_1'),
        ).thenAnswer((_) async => false);
        when(
          mockVkService.getArtistById('artist_1'),
        ).thenThrow(Exception('API Error'));
        when(
          mockAudioStorage.markArtistPhotoChecked('artist_1', false),
        ).thenAnswer((_) async {});

        // Вызываем метод
        final result = await audioRepository.getArtistsWithPhotos();

        // Проверяем результат
        expect(result.length, equals(1));
        expect(result.first.id, equals(1));
        expect(result.first.name, equals('Artist 1'));
        expect(result.first.photo, isNull);

        // Проверяем что артист помечен как проверенный
        verify(
          mockAudioStorage.markArtistPhotoChecked('artist_1', false),
        ).called(1);
      });

      test('Should handle tracks without main artists', () async {
        // Подготавливаем тестовые данные
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([track]));

        // Вызываем метод
        final result = await audioRepository.getArtistsWithPhotos();

        // Проверяем результат
        expect(result.length, equals(0));
      });

      test('Should handle multiple artists per track', () async {
        // Подготавливаем тестовые данные
        const track = VkAudioTrack(
          id: 1,
          ownerId: 100,
          title: 'Test Track',
          artist: 'Test Artist',
          duration: 180,
          url: 'https://example.com/track.mp3',
          mainArtists: [
            VkMainArtist(name: 'Artist 1', domain: 'artist1', id: 'artist_1'),
            VkMainArtist(name: 'Artist 2', domain: 'artist2', id: 'artist_2'),
          ],
        );

        final cachedArtist1 = VkArtist(
          id: 1,
          name: 'Artist 1',
          domain: 'artist1',
          photo: 'https://example.com/photo1.jpg',
        );

        const artistInfo2 = VkArtistInfo(
          id: 'artist_2',
          name: 'Artist 2',
          domain: 'artist2',
          photos: [
            VkArtistPhoto(
              type: 'crop',
              photo: [
                VkArtistPhotoSize(
                  url: 'https://example.com/photo2.jpg',
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ],
        );

        final expectedArtist2 = VkArtist(
          id: 2,
          name: 'Artist 2',
          domain: 'artist2',
          photo: 'https://example.com/photo2.jpg',
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getTracks(),
        ).thenAnswer((_) async => IListConst([track]));
        when(
          mockAudioStorage.getCachedArtist('artist_1'),
        ).thenAnswer((_) async => cachedArtist1);
        when(
          mockAudioStorage.getCachedArtist('artist_2'),
        ).thenAnswer((_) async => null);
        when(
          mockAudioStorage.isArtistPhotoChecked('artist_2'),
        ).thenAnswer((_) async => false);
        when(
          mockVkService.getArtistById('artist_2'),
        ).thenAnswer((_) async => artistInfo2);
        when(
          mockAudioStorage.saveCachedArtist(_dummyArtist),
        ).thenAnswer((_) async {});

        // Вызываем метод
        final result = await audioRepository.getArtistsWithPhotos();

        // Проверяем результат
        expect(result.length, equals(2));

        // Проверяем первого артиста (из кеша)
        final artist1 = result.firstWhere((a) => a.id == 1);
        expect(artist1.name, equals('Artist 1'));
        expect(artist1.photo, equals('https://example.com/photo1.jpg'));

        // Проверяем второго артиста (загружен из API)
        final artist2 = result.firstWhere((a) => a.id == 2);
        expect(artist2.name, equals('Artist 2'));
        expect(artist2.photo, equals('https://example.com/photo2.jpg'));

        // Проверяем что второй артист был сохранен в кеш
        verify(mockAudioStorage.saveCachedArtist(_dummyArtist)).called(1);
      });
    });

    group('updateArtistPhotosInBackground', () {
      test('Should update artists in batches', () async {
        // Подготавливаем тестовые данные
        const artistInfo = VkArtistInfo(
          id: 'artist_1',
          name: 'Artist 1',
          domain: 'artist1',
          photos: [
            VkArtistPhoto(
              type: 'crop',
              photo: [
                VkArtistPhotoSize(
                  url: 'https://example.com/photo1.jpg',
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ],
        );

        final expectedArtist = VkArtist(
          id: 1,
          name: 'Artist 1',
          domain: 'artist1',
          photo: 'https://example.com/photo1.jpg',
        );

        // Настраиваем моки
        when(
          mockAudioStorage.getArtistsToUpdate(),
        ).thenAnswer((_) async => IListConst(['artist_1']));
        when(
          mockAudioStorage.isArtistPhotoChecked('artist_1'),
        ).thenAnswer((_) async => false);
        when(
          mockVkService.getArtistById('artist_1'),
        ).thenAnswer((_) async => artistInfo);
        when(
          mockAudioStorage.saveCachedArtist(_dummyArtist),
        ).thenAnswer((_) async {});

        // Вызываем метод
        await audioRepository.updateArtistPhotosInBackground();

        // Проверяем что артист был сохранен в кеш
        verify(mockAudioStorage.saveCachedArtist(_dummyArtist)).called(1);
      });

      test('Should handle API errors in background update', () async {
        // Настраиваем моки
        when(
          mockAudioStorage.getArtistsToUpdate(),
        ).thenAnswer((_) async => IListConst(['artist_1']));
        when(
          mockAudioStorage.isArtistPhotoChecked('artist_1'),
        ).thenAnswer((_) async => false);
        when(
          mockVkService.getArtistById('artist_1'),
        ).thenThrow(Exception('API Error'));
        when(
          mockAudioStorage.markArtistPhotoChecked('artist_1', false),
        ).thenAnswer((_) async {});

        // Вызываем метод
        await audioRepository.updateArtistPhotosInBackground();

        // Проверяем что артист помечен как проверенный
        verify(
          mockAudioStorage.markArtistPhotoChecked('artist_1', false),
        ).called(1);
      });

      test('Should skip already checked artists', () async {
        // Настраиваем моки
        when(
          mockAudioStorage.getArtistsToUpdate(),
        ).thenAnswer((_) async => IListConst(['artist_1']));
        when(
          mockAudioStorage.isArtistPhotoChecked('artist_1'),
        ).thenAnswer((_) async => true);

        // Вызываем метод
        await audioRepository.updateArtistPhotosInBackground();

        // Проверяем что не было вызовов к VK API
        verifyNever(mockVkService.getArtistById(any));
      });

      test('Should handle empty artists to update', () async {
        // Настраиваем моки
        when(
          mockAudioStorage.getArtistsToUpdate(),
        ).thenAnswer((_) async => IListConst([]));

        // Вызываем метод
        await audioRepository.updateArtistPhotosInBackground();

        // Проверяем что не было вызовов к VK API
        verifyNever(mockVkService.getArtistById(any));
      });
    });
  });
}
