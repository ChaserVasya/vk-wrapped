import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/data/local/audio_storage/drift/database.dart';

abstract interface class AudioStorage {
  Future<IList<VkAudioTrack>> getTracks();

  Future<void> updateTracks(IList<VkAudioTrack> tracks);

  Future<void> deleteAllTracks();

  /// Проверяет, является ли трек недоступным
  Future<bool> isTrackUnavailable(int id, int ownerId);

  /// Добавляет трек в список недоступных
  Future<void> markTrackAsUnavailable(int id, int ownerId, String fullId);

  /// Получает количество недоступных треков
  Future<int> getUnavailableTracksCount();

  /// Получает список недоступных треков
  Future<IList<UnavailableTrack>> getUnavailableTracks();

  /// Очищает список недоступных треков
  Future<void> clearUnavailableTracks();
}
