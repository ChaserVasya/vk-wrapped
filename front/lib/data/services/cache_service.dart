import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/services/cache_service_interface.dart'
    as cache_interface;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Улучшенный сервис для кэширования данных
@lazySingleton
class CacheService implements cache_interface.CacheService {
  static const String _tracksKey = 'cached_tracks';
  static const String _statisticsKey = 'cached_statistics';
  static const String _tokenKey = 'vk_token';
  static const String _lastUpdateKey = 'last_cache_update';
  static const Duration _cacheStaleDuration = Duration(hours: 24);

  /// Кэширует список треков
  @override
  Future<void> cacheTracks(List<AudioTrack> tracks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tracksJson = tracks.map((track) => track.toJson()).toList();
      await prefs.setString(_tracksKey, tracksJson.toString());
      await prefs.setString(_lastUpdateKey, DateTime.now().toIso8601String());
    } catch (e) {
      throw CacheException('Failed to cache tracks: $e');
    }
  }

  /// Получает кэшированные треки
  @override
  Future<List<AudioTrack>> getCachedTracks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tracksJsonString = prefs.getString(_tracksKey);
      if (tracksJsonString == null) return [];

      // Простая реализация для демонстрации
      return [];
    } catch (e) {
      throw CacheException('Failed to get cached tracks: $e');
    }
  }

  /// Кэширует статистику
  @override
  Future<void> cacheStatistics(
    String key,
    Map<String, dynamic> statistics,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final statisticsKey = '${_statisticsKey}_$key';
      await prefs.setString(statisticsKey, statistics.toString());
    } catch (e) {
      throw CacheException('Failed to cache statistics: $e');
    }
  }

  /// Получает кэшированную статистику
  @override
  Future<Map<String, dynamic>?> getCachedStatistics(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final statisticsKey = '${_statisticsKey}_$key';
      final statisticsString = prefs.getString(statisticsKey);
      if (statisticsString == null) return null;

      // Простая реализация для демонстрации
      return {};
    } catch (e) {
      throw CacheException('Failed to get cached statistics: $e');
    }
  }

  /// Сохраняет токен
  @override
  Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw CacheException('Failed to save token: $e');
    }
  }

  /// Получает токен
  @override
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw CacheException('Failed to get token: $e');
    }
  }

  /// Проверяет наличие токена
  @override
  Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Очищает весь кэш
  @override
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tracksKey);
      await prefs.remove(_lastUpdateKey);
      // Очищаем все ключи статистики
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith(_statisticsKey)) {
          await prefs.remove(key);
        }
      }
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }

  /// Очищает токен
  @override
  Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    } catch (e) {
      throw CacheException('Failed to clear token: $e');
    }
  }

  /// Проверяет устарел ли кэш
  @override
  Future<bool> isCacheStale() async {
    try {
      final lastUpdate = await getLastCacheUpdate();
      if (lastUpdate == null) return true;

      final now = DateTime.now();
      final difference = now.difference(lastUpdate);
      return difference > _cacheStaleDuration;
    } catch (e) {
      return true;
    }
  }

  /// Получает время последнего обновления кэша
  @override
  Future<DateTime?> getLastCacheUpdate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastUpdateString = prefs.getString(_lastUpdateKey);
      if (lastUpdateString == null) return null;

      return DateTime.parse(lastUpdateString);
    } catch (e) {
      return null;
    }
  }

  /// Сохраняет clientId
  @override
  Future<void> saveClientId(String clientId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('client_id', clientId);
    } catch (e) {
      throw CacheException('Failed to save client ID: $e');
    }
  }

  /// Получает clientId
  @override
  Future<String?> getClientId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('client_id');
    } catch (e) {
      throw CacheException('Failed to get client ID: $e');
    }
  }
}
