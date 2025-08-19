import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:injectable/injectable.dart';

/// Результат загрузки аудио с информацией об ошибках
class VkAudioResult {
  final IList<VkAudioTrack> tracks;
  final IList<AppException> errors;
  final String? errorMessage;

  const VkAudioResult({
    required this.tracks,
    required this.errors,
    this.errorMessage,
  });

  /// Есть ли ошибки при загрузке
  bool get hasErrors => errors.isNotEmpty || errorMessage != null;

  /// Количество успешно загруженных треков
  int get successCount => tracks.length;

  /// Общее количество запрошенных ID
  int get totalRequested => tracks.length + errors.length;
}

@lazySingleton
class VkService {
  final VkApiClient _client;
  final PrefsStorage _prefsStorage;

  VkService(this._prefsStorage, this._client);

  /// Максимальное количество аудио ID в одном запросе
  /// VK API имеет ограничение на длину URL, поэтому разбиваем на пакеты
  /// 44 элемента уже вызывают ошибку 414, поэтому используем безопасный порог
  static const int _maxBatchSize = 30;

  /// Получает аудио по ID
  Future<VkAudioResult> getAudioById(IList<String> audioIds) async {
    if (audioIds.isEmpty) {
      return const VkAudioResult(
        tracks: IListConst([]),
        errors: IListConst([]),
      );
    }

    // Убираем дубликаты
    final uniqueAudioIds = audioIds.toSet().toList();
    if (uniqueAudioIds.length != audioIds.length) {
      print(
        '[INFO] Removed ${audioIds.length - uniqueAudioIds.length} duplicate audio IDs (${audioIds.length} -> ${uniqueAudioIds.length})',
      );
    }

    final allTracks = <VkAudioTrack>[];
    final errors = <AppException>[];
    final networkErrorBatches = <List<String>>[];

    // Разбиваем на пакеты по _maxBatchSize элементов
    for (int i = 0; i < uniqueAudioIds.length; i += _maxBatchSize) {
      final end = (i + _maxBatchSize < uniqueAudioIds.length)
          ? i + _maxBatchSize
          : uniqueAudioIds.length;
      final batch = uniqueAudioIds.sublist(i, end);

      try {
        final audiosParam = batch.join(',');
        final res = await _client.getAudioById(
          audios: audiosParam,
          accessToken: _token,
        );

        // Проверяем есть ли ошибка VK API
        if (res.error != null) {
          // Ошибка VK API - обрабатываем в зависимости от кода ошибки
          if (res.error!.errorCode == 100) {
            // Ошибка 100 - недоступные аудио
            for (final audioId in batch) {
              errors.add(VkAudioUnavailableException(audioId));
            }
            print(
              '[INFO] VK API error 100 - audio tracks are unavailable in batch ${i ~/ _maxBatchSize + 1}: ${batch.length} tracks',
            );
          } else {
            // Другие ошибки VK API
            for (final audioId in batch) {
              errors.add(
                AppException(
                  'VK API error ${res.error!.errorCode}: ${res.error!.errorMsg} for $audioId',
                  code: 'VK_${res.error!.errorCode}',
                ),
              );
            }
            networkErrorBatches.add(batch);
            print(
              '[ERROR] VK API error ${res.error!.errorCode} in batch ${i ~/ _maxBatchSize + 1}: ${res.error!.errorMsg}',
            );
          }
          continue;
        }

        // Успешный ответ - добавляем треки
        if (res.response != null) {
          allTracks.addAll(res.response!);
          print(
            '[DEBUG] VkService: Loaded ${res.response!.length} tracks from batch ${i ~/ _maxBatchSize + 1}',
          );
          print(
            '[DEBUG] VkService: Sample loaded track IDs: ${res.response!.take(3).map((t) => t.fullId).join(', ')}',
          );

          // Определяем недоступные треки через сравнение
          final receivedIds = res.response!
              .map((track) => '${track.ownerId}_${track.id}')
              .toSet();
          final unavailableIds = batch
              .where((id) => !receivedIds.contains(id))
              .toList();

          // Создаем исключения для недоступных треков
          for (final audioId in unavailableIds) {
            errors.add(VkAudioUnavailableException(audioId));
          }

          if (unavailableIds.isNotEmpty) {
            print(
              '[INFO] Audio tracks are unavailable in batch ${i ~/ _maxBatchSize + 1}: ${unavailableIds.length} tracks',
            );
            print(
              '[DEBUG] VkService: Unavailable track IDs: ${unavailableIds.take(5).join(', ')}',
            );
          }
        }
      } catch (e) {
        // Проверяем, является ли это ошибкой токена - если да, пробрасываем как есть
        if (e is NoTokenException || e is VkAuthFailedException) {
          rethrow;
        }

        // Сетевые или другие ошибки - создаем AppException для каждого ID в batch
        for (final audioId in batch) {
          errors.add(
            AppException('Ошибка загрузки аудио: $audioId', originalError: e),
          );
        }
        networkErrorBatches.add(batch);
        print(
          '[ERROR] Failed to load batch ${i ~/ _maxBatchSize + 1} with ${batch.length} tracks: $e',
        );
      }
    }

    // Формируем сообщение об ошибке только для сетевых ошибок
    String? errorMessage;
    if (networkErrorBatches.isNotEmpty) {
      final totalNetworkFailed = networkErrorBatches.fold<int>(
        0,
        (sum, batch) => sum + batch.length,
      );
      final totalRequested = uniqueAudioIds.length;
      final successCount = allTracks.length;

      errorMessage =
          'Не удалось загрузить $totalNetworkFailed из $totalRequested треков из-за ошибок сети. Успешно загружено: $successCount.';

      print(
        '[WARNING] Failed to load $totalNetworkFailed tracks due to network errors out of ${uniqueAudioIds.length} total',
      );
    }

    return VkAudioResult(
      tracks: allTracks.toIList(),
      errors: errors.toIList(),
      errorMessage: errorMessage,
    );
  }

  /// Получает информацию об артисте по его ID
  Future<VkArtistInfo> getArtistById(String artistId) async {
    final response = await _client.getArtistById(
      artistId: artistId,
      accessToken: _token,
    );
    return response.response;
  }

  String get _token {
    final token = _prefsStorage.getToken();
    if (token == null) {
      throw const NoTokenException();
    }
    final expiresAt = _prefsStorage.getTokenExpiry();
    if (expiresAt != null && DateTime.now().isAfter(expiresAt)) {
      throw const VkAuthFailedException();
    }
    return token;
  }
}
