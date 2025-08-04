import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CacheService {
  static const String _tracksKey = 'cached_tracks';
  static const String _statisticsPrefix = 'cached_statistics_';
  static const String _tokenKey = 'vk_token';
  static const String _clientIdKey = 'client_id';

  /// Кэширует треки
  Future<void> cacheTracks(IList<AudioTrack> tracks) async {
    final prefs = await SharedPreferences.getInstance();
    final tracksJson = tracks.map((track) => track.toJson()).toList();
    await prefs.setString(_tracksKey, jsonEncode(tracksJson));
  }

  /// Получает кэшированные треки
  Future<IList<AudioTrack>> getCachedTracks() async {
    final prefs = await SharedPreferences.getInstance();
    final tracksJson = prefs.getString(_tracksKey);

    if (tracksJson == null) {
      return const IListConst([]);
    }

    final tracksList = jsonDecode(tracksJson) as List;
    return tracksList
        .map((json) => AudioTrack.fromJson(json as Map<String, dynamic>))
        .toIList();
  }

  /// Кэширует статистику
  Future<void> cacheStatistics(
    String key,
    IMap<String, dynamic> statistics,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '$_statisticsPrefix$key';
    await prefs.setString(cacheKey, jsonEncode(statistics));
  }

  /// Получает кэшированную статистику
  Future<IMap<String, dynamic>?> getCachedStatistics(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '$_statisticsPrefix$key';
    final statisticsJson = prefs.getString(cacheKey);

    if (statisticsJson == null) {
      return null;
    }

    final statisticsMap = jsonDecode(statisticsJson) as Map<String, dynamic>;
    return statisticsMap.toIMap();
  }

  /// Сохраняет токен
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Получает токен
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Удаляет токен
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// Сохраняет clientId
  Future<void> saveClientId(String clientId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_clientIdKey, clientId);
  }

  /// Получает clientId
  Future<String?> getClientId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_clientIdKey);
  }

  /// Очищает кэш
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tracksKey);

    // Очищаем все кэшированные статистики
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_statisticsPrefix)) {
        await prefs.remove(key);
      }
    }
  }
}
