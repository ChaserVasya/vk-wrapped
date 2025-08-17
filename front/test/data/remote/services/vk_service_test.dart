import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/local/audio_storage/audio_storage.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/data/remote/services/vk_service.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vk_service_test.mocks.dart';

@GenerateMocks([VkApiClient, PrefsStorage])
void main() {
  group('VkService', () {
    late MockVkApiClient mockVkApiClient;
    late MockPrefsStorage mockPrefsStorage;
    late VkService vkService;

    setUp(() {
      mockVkApiClient = MockVkApiClient();
      mockPrefsStorage = MockPrefsStorage();
      vkService = VkService(mockPrefsStorage, mockVkApiClient);
    });

    group('getAudioById', () {
      test('Should return empty result when no audio IDs provided', () async {
        final result = await vkService.getAudioById(const IListConst([]));
        expect(result.tracks, isEmpty);
        expect(result.errors, isEmpty);
        expect(result.errorMessage, isNull);
      });

      test('Should process all audio IDs without filtering', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);
        when(
          mockVkApiClient.getAudioById(
            audios: '123_456,789_101',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer(
          (_) async => VkAudioResponse(response: const IListConst([])),
        );

        // Вызываем метод
        await vkService.getAudioById(const IListConst(['123_456', '789_101']));

        // Проверяем что API вызван для всех треков
        verify(
          mockVkApiClient.getAudioById(
            audios: '123_456,789_101',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).called(1);
      });

      test('Should remove duplicate audio IDs', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);
        when(
          mockVkApiClient.getAudioById(
            audios: '1_100,2_200,3_300',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer(
          (_) async => VkAudioResponse(response: const IListConst([])),
        );

        final audioIds = const IListConst(['1_100', '2_200', '1_100', '3_300']);
        final result = await vkService.getAudioById(audioIds);
        expect(result.tracks, isEmpty);
        expect(
          result.errors,
          isNotEmpty,
        ); // Теперь правильно определяем недоступные треки
        expect(result.errorMessage, isNull);
      });

      test('Should handle invalid audio ID format', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);
        when(
          mockVkApiClient.getAudioById(
            audios: 'invalid_id',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenThrow(Exception('Invalid format'));

        // Вызываем метод с неверным форматом ID
        final result = await vkService.getAudioById(
          const IListConst(['invalid_id']),
        );

        // Проверяем что результат содержит ошибку
        expect(result.tracks, isEmpty);
        expect(result.errors, isNotEmpty);
        expect(result.errorMessage, isNotNull);
      });

      test('Should handle VK API error 100 for unavailable audio', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);
        when(
          mockVkApiClient.getAudioById(
            audios: '999999999_999999999',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer(
          (_) async => VkAudioResponse(
            response: null,
            error: VkError(
              errorCode: 100,
              errorMsg:
                  'One of the parameters specified was missing or invalid: audios is invalid',
            ),
          ),
        );

        // Вызываем метод с недоступным аудио
        final result = await vkService.getAudioById(
          const IListConst(['999999999_999999999']),
        );

        // Проверяем что создается VkAudioUnavailableException
        expect(result.tracks, isEmpty);
        expect(result.errors, hasLength(1));
        expect(result.errors.first, isA<VkAudioUnavailableException>());
        expect(result.errorMessage, isNull);
      });

      test('Should handle other VK API errors', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);
        when(
          mockVkApiClient.getAudioById(
            audios: '1_100',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer(
          (_) async => VkAudioResponse(
            response: null,
            error: VkError(errorCode: 15, errorMsg: 'Access denied'),
          ),
        );

        // Вызываем метод с ошибкой доступа
        final result = await vkService.getAudioById(
          const IListConst(['1_100']),
        );

        // Проверяем что создается AppException
        expect(result.tracks, isEmpty);
        expect(result.errors, hasLength(1));
        expect(result.errors.first, isA<AppException>());
        expect(result.errorMessage, isNotNull);
      });

      test(
        'Should correctly identify unavailable tracks by comparison',
        () async {
          // Настраиваем моки
          when(mockPrefsStorage.getToken()).thenReturn('test_token');
          when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

          const availableTrack = VkAudioTrack(
            id: 1,
            ownerId: 100,
            title: 'Available Track',
            artist: 'Artist A',
            duration: 180,
            url: 'https://example.com/track1.mp3',
          );

          when(
            mockVkApiClient.getAudioById(
              audios: '100_1,200_2',
              accessToken: 'test_token',
              version: '5.131',
            ),
          ).thenAnswer(
            (_) async => VkAudioResponse(
              response: IListConst([
                availableTrack,
              ]), // только один трек из двух
            ),
          );

          // Вызываем метод с доступным и недоступным треком
          final result = await vkService.getAudioById(
            const IListConst(['100_1', '200_2']),
          );

          // Проверяем что правильно определены недоступные треки
          expect(result.tracks, hasLength(1));
          expect(result.tracks.first, equals(availableTrack));
          expect(result.errors, hasLength(1)); // только 2_200 недоступен
          expect(result.errors.first, isA<VkAudioUnavailableException>());
          expect(result.errorMessage, isNull);
        },
      );

      test(
        'Should handle mixed available and unavailable tracks in batch',
        () async {
          // Настраиваем моки
          when(mockPrefsStorage.getToken()).thenReturn('test_token');
          when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

          const track1 = VkAudioTrack(
            id: 1,
            ownerId: 100,
            title: 'Track 1',
            artist: 'Artist A',
            duration: 180,
            url: 'https://example.com/track1.mp3',
          );

          const track3 = VkAudioTrack(
            id: 3,
            ownerId: 300,
            title: 'Track 3',
            artist: 'Artist C',
            duration: 200,
            url: 'https://example.com/track3.mp3',
          );

          when(
            mockVkApiClient.getAudioById(
              audios: '100_1,200_2,300_3',
              accessToken: 'test_token',
              version: '5.131',
            ),
          ).thenAnswer(
            (_) async => VkAudioResponse(
              response: IListConst([track1, track3]), // 200_2 недоступен
            ),
          );

          // Вызываем метод с тремя треками, один недоступен
          final result = await vkService.getAudioById(
            const IListConst(['100_1', '200_2', '300_3']),
          );

          // Проверяем результат
          expect(result.tracks, hasLength(2));
          expect(
            result.tracks.map((t) => t.fullId).toSet(),
            containsAll(['100_1', '300_3']),
          );
          expect(result.errors, hasLength(1));
          expect(result.errors.first, isA<VkAudioUnavailableException>());
          expect(result.errorMessage, isNull);
        },
      );

      test('Should handle VK API response with null values', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

        // Симулируем ответ VK API с null значениями (как в реальности)
        when(
          mockVkApiClient.getAudioById(
            audios: '383475766_456242924',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer(
          (_) async => VkAudioResponse(
            response: IListConst([
              VkAudioTrack(
                id: 456242924,
                ownerId: 383475766,
                title: 'Test Track',
                artist: 'Test Artist',
                duration: 180,
                url: 'https://example.com/track.mp3',
                date: null, // null значение
                genreId: null, // null значение
                lyricsId: null, // null значение
                album: null, // null значение
                mainArtists: null, // null значение
              ),
            ]),
          ),
        );

        // Вызываем метод с реальным ID
        final result = await vkService.getAudioById(
          const IListConst(['383475766_456242924']),
        );

        // Проверяем что трек загружен без ошибок
        expect(result.tracks, hasLength(1));
        expect(result.errors, isEmpty);
        expect(result.errorMessage, isNull);
      });

      test(
        'Should handle real VK API response for unavailable track',
        () async {
          // Настраиваем моки
          when(mockPrefsStorage.getToken()).thenReturn('test_token');
          when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

          // Симулируем реальный ответ VK API для недоступного трека
          when(
            mockVkApiClient.getAudioById(
              audios: '383475766_456242932',
              accessToken: 'test_token',
              version: '5.131',
            ),
          ).thenAnswer(
            (_) async => VkAudioResponse(
              response: IListConst([]), // пустой ответ - трек недоступен
            ),
          );

          // Вызываем метод с реальным недоступным ID
          final result = await vkService.getAudioById(
            const IListConst(['383475766_456242932']),
          );

          // Проверяем что недоступный трек помечен как ошибка
          expect(result.tracks, isEmpty);
          expect(result.errors, hasLength(1));
          expect(result.errors.first, isA<VkAudioUnavailableException>());
          expect(result.errorMessage, isNull);
        },
      );

      test('Should handle real VK API JSON response', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

        // Симулируем реальный JSON ответ VK API
        when(
          mockVkApiClient.getAudioById(
            audios: '383475766_456242932',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer((_) async {
          // Симулируем парсинг JSON с потенциальными null значениями
          final jsonResponse = {
            'response': [], // пустой массив
          };

          return VkAudioResponse.fromJson(jsonResponse);
        });

        // Вызываем метод с реальным недоступным ID
        final result = await vkService.getAudioById(
          const IListConst(['383475766_456242932']),
        );

        // Проверяем что недоступный трек помечен как ошибка
        expect(result.tracks, isEmpty);
        expect(result.errors, hasLength(1));
        expect(result.errors.first, isA<VkAudioUnavailableException>());
        expect(result.errorMessage, isNull);
      });

      test('Should handle real VK API error response', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

        // Симулируем реальную ошибку VK API
        when(
          mockVkApiClient.getAudioById(
            audios: '383475766_456242932',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer((_) async {
          // Симулируем парсинг JSON с ошибкой
          final jsonResponse = {
            'error': {
              'error_code': 100,
              'error_msg':
                  'One of the parameters specified was missing or invalid: audios is invalid',
              'request_params': [
                {'key': 'audios', 'value': '383475766_456242932'},
              ],
            },
          };

          return VkAudioResponse.fromJson(jsonResponse);
        });

        // Вызываем метод с реальным недоступным ID
        final result = await vkService.getAudioById(
          const IListConst(['383475766_456242932']),
        );

        // Проверяем что недоступный трек помечен как ошибка
        expect(result.tracks, isEmpty);
        expect(result.errors, hasLength(1));
        expect(result.errors.first, isA<VkAudioUnavailableException>());
        expect(result.errorMessage, isNull);
      });

      test('Should handle real VK API response with additional fields', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

        // Симулируем реальный ответ VK API с дополнительными полями
        when(
          mockVkApiClient.getAudioById(
            audios: '383475766_456242924',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).thenAnswer((_) async {
          // Симулируем парсинг JSON с реальными полями VK API
          final jsonResponse = {
            'response': [
              {
                'artist': 'Justin Bieber',
                'id': 456242924,
                'owner_id': 383475766,
                'title': 'SWAG (Feat. Cash Cobain & Eddie Benjamin)',
                'duration': 150,
                'access_key': '7ec9e9c0887c6a450f',
                'ads': {
                  'content_id': '383475766_456242924',
                  'duration': '150',
                  'account_age_type': '3',
                  'puid22': '11',
                },
                'is_explicit': false,
                'is_focus_track': false,
                'is_licensed': true,
                'track_code':
                    '27ec6a98jsMJ5V2e7Ph0epaqAj63VOVDTUQLerjS7zPHd1PgNBrncq1tjf51ecajl6qE',
                'url':
                    'https://cs9-8v4.vkuseraudio.net/s/v1/ac/3SyxIlE-NlUPLlsFZsvVWXMrEWG3jFX6RgmtNac50ygPiqrnz6xJzhTZx5v6Scs9tYh3N8OqO27nC15GRUUqZ8w_-HCtbz-qMdYhu73xRyYp_tpXQicWhf9zCBOHH-n7CCEfGtL_DuuFjnWqTw-0crzoqjBd3ZbEclIk4TcdWdN5ZVQ/index.m3u8?siren=1',
                'date': 1752398504,
                'genre_id': 2,
                'short_videos_allowed': false,
                'stories_allowed': false,
                'stories_cover_allowed': false,
              },
            ],
          };

          return VkAudioResponse.fromJson(jsonResponse);
        });

        // Вызываем метод с реальным доступным ID
        final result = await vkService.getAudioById(
          const IListConst(['383475766_456242924']),
        );

        // Проверяем что трек загружен без ошибок
        expect(result.tracks, hasLength(1));
        expect(result.errors, isEmpty);
        expect(result.errorMessage, isNull);
      });
    });

    group('getArtistById', () {
      test('Should return artist info from API', () async {
        // Настраиваем моки
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(mockPrefsStorage.getTokenExpiry()).thenReturn(null);

        const expectedArtistInfo = VkArtistInfo(
          name: 'Test Artist',
          domain: 'test_artist',
          id: '123',
          photos: null,
        );

        when(
          mockVkApiClient.getArtistById(
            artistId: anyNamed('artistId'),
            accessToken: anyNamed('accessToken'),
            version: anyNamed('version'),
          ),
        ).thenAnswer(
          (_) async => VkArtistResponse(response: expectedArtistInfo),
        );

        // Вызываем метод
        final result = await vkService.getArtistById('123');

        // Проверяем результат
        expect(result, equals(expectedArtistInfo));
        verify(
          mockVkApiClient.getArtistById(
            artistId: '123',
            accessToken: 'test_token',
            version: '5.131',
          ),
        ).called(1);
      });
    });

    group('Token handling', () {
      test('Should throw NoTokenException when token is null', () {
        when(mockPrefsStorage.getToken()).thenReturn(null);

        expect(
          () => vkService.getArtistById('123'),
          throwsA(isA<NoTokenException>()),
        );
      });

      test('Should throw VkAuthFailedException when token is expired', () {
        when(mockPrefsStorage.getToken()).thenReturn('test_token');
        when(
          mockPrefsStorage.getTokenExpiry(),
        ).thenReturn(DateTime.now().subtract(const Duration(hours: 1)));

        expect(
          () => vkService.getArtistById('123'),
          throwsA(isA<VkAuthFailedException>()),
        );
      });
    });
  });
}
