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

          // Вызываем метод
          final (tracks, resultSessions) = await audioRepository.getAudioData();

          // Проверяем что недоступный трек помечен как недоступный
          expect(tracks.length, equals(1)); // только localTrack
          expect(resultSessions.length, equals(2)); // все сессии

          // Проверяем что markTrackAsUnavailable был вызван только для недоступного трека
          verify(
            mockAudioStorage.markTrackAsUnavailable(2, 200, '2_200'),
          ).called(1);
          verifyNever(mockAudioStorage.markTrackAsUnavailable(3, 300, '3_300'));
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

        // Вызываем метод - теперь он не выбрасывает исключение для недоступных треков
        final (tracks, resultSessions) = await audioRepository.getAudioData();

        // Проверяем что недоступные треки отфильтрованы
        expect(tracks.length, equals(1)); // localTrack
        expect(resultSessions.length, equals(1)); // только valid сессия
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
  });
}
