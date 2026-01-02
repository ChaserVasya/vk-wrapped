import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/data/local/audio_storage/drift/database.dart';
import 'package:front/domain/entities/track_session.dart';

abstract interface class AudioStorage {
  Future<IList<VkAudioTrack>> getTracks();

  Future<void> updateTracks(IList<VkAudioTrack> tracks);

  Future<void> deleteAllTracks();

  /// Проверяет, является ли трек недоступным
  Future<bool> isTrackUnavailable(int id, int ownerId);

  /// Добавляет трек в список недоступных
  Future<void> markTrackAsUnavailable(int id, int ownerId, String fullId);

  /// Получает количество недоступных треков
  /// Если [sessions] передан, считает только треки из этих сессий
  Future<int> getUnavailableTracksCount({IList<TrackSession>? sessions});

  /// Получает список недоступных треков
  Future<IList<UnavailableTrack>> getUnavailableTracks();

  /// Очищает список недоступных треков
  Future<void> clearUnavailableTracks();

  /// Получает кешированного артиста по ID
  Future<VkArtist?> getCachedArtist(String artistId);

  /// Сохраняет артиста в кеш
  /// [artistId] - оригинальный ID артиста (String) из VK API
  Future<void> saveCachedArtist(VkArtist artist, String artistId);

  /// Получает всех кешированных артистов
  Future<IList<VkArtist>> getAllCachedArtists();

  /// Проверяет, была ли уже проверена фотография артиста
  Future<bool> isArtistPhotoChecked(String artistId);

  /// Помечает что фотография артиста была проверена
  Future<void> markArtistPhotoChecked(String artistId, bool hasPhoto);

  /// Получает артистов, которые нужно обновить (без фото и не проверенных)
  Future<IList<String>> getArtistsToUpdate();
}
