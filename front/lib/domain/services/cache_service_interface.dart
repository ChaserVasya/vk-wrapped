import 'package:front/domain/entities/audio_track.dart';

abstract class CacheServiceInterface {
  Future<void> cacheTracks(List<AudioTrack> tracks);
  Future<List<AudioTrack>> getCachedTracks();
  Future<void> cacheStatistics(String key, Map<String, dynamic> statistics);
  Future<Map<String, dynamic>?> getCachedStatistics(String key);
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<bool> hasToken();
  Future<void> clearToken();
  Future<void> clearCache();
  Future<bool> isCacheStale();
  Future<DateTime?> getLastCacheUpdate();
}
