import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Сервис для кэширования данных
class CacheService {
  static const String _tracksKey = 'cached_tracks';
  static const String _statisticsKey = 'cached_statistics';
  static const String _tokenKey = 'vk_token';

  /// Сохраняет треки в кэш
  static Future<void> cacheTracks(List<Map<String, dynamic>> tracks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(tracks);
    await prefs.setString(_tracksKey, jsonString);
  }

  /// Получает треки из кэша
  static Future<List<Map<String, dynamic>>> getCachedTracks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_tracksKey);
    if (jsonString == null) return [];

    final List<dynamic> tracks = jsonDecode(jsonString);
    return tracks.cast<Map<String, dynamic>>();
  }

  /// Сохраняет статистику в кэш
  static Future<void> cacheStatistics(Map<String, dynamic> statistics) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(statistics);
    await prefs.setString(_statisticsKey, jsonString);
  }

  /// Получает статистику из кэша
  static Future<Map<String, dynamic>?> getCachedStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_statisticsKey);
    if (jsonString == null) return null;

    return jsonDecode(jsonString);
  }

  /// Сохраняет VK токен
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Получает VK токен
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Очищает весь кэш
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tracksKey);
    await prefs.remove(_statisticsKey);
  }

  /// Очищает только токен
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
