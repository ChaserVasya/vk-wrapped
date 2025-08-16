import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VkService {
  final VkApiClient _client;
  final PrefsStorage _prefsStorage;

  VkService(this._prefsStorage, this._client);

  /// Максимальное количество аудио ID в одном запросе
  /// VK API имеет ограничение на длину URL, поэтому разбиваем на пакеты
  /// 44 элемента уже вызывают ошибку 414, поэтому используем безопасный порог
  static const int _maxBatchSize = 30;

  Future<IList<VkAudioTrack>> getAudioById(Iterable<String> audioIds) async {
    if (audioIds.isEmpty) {
      return const IListConst([]);
    }

    final audioIdsList = audioIds.toList();
    final allTracks = <VkAudioTrack>[];
    final failedBatches = <List<String>>[];

    // Разбиваем на пакеты по _maxBatchSize элементов
    for (int i = 0; i < audioIdsList.length; i += _maxBatchSize) {
      final end = (i + _maxBatchSize < audioIdsList.length)
          ? i + _maxBatchSize
          : audioIdsList.length;
      final batch = audioIdsList.sublist(i, end);

      try {
        final audiosParam = batch.join(',');
        final res = await _client.getAudioById(
          audios: audiosParam,
          accessToken: _token,
        );

        allTracks.addAll(res.response);
      } catch (e) {
        // Логируем ошибку и сохраняем информацию о неудачном пакете
        failedBatches.add(batch);
        print(
          '[ERROR] Failed to load batch ${i ~/ _maxBatchSize + 1} with ${batch.length} tracks: $e',
        );
      }
    }

    // Логируем итоговую статистику
    if (failedBatches.isNotEmpty) {
      final totalFailed = failedBatches.fold<int>(
        0,
        (sum, batch) => sum + batch.length,
      );
      print(
        '[WARNING] Failed to load $totalFailed tracks out of ${audioIdsList.length} total',
      );
    }

    return allTracks.toIList();
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
