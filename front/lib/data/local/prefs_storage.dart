import 'package:front/domain/storages/auth_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthStorage)
class PrefsStorage implements AuthStorage {
  static const String _tokenKey = 'vk_token';
  static const String _vkAppId = 'vk_app_id';

  const PrefsStorage(this._prefs);

  final SharedPreferencesWithCache _prefs;

  /// token id

  @override
  Future<void> saveToken(String token) async =>
      await _prefs.setString(_tokenKey, token);

  @override
  String? getToken() => _prefs.getString(_tokenKey);

  @override
  Future<void> clearToken() async => await _prefs.remove(_tokenKey);

  /// client id

  @override
  Future<void> saveVkAppId(String vkAppId) async =>
      await _prefs.setString(_vkAppId, vkAppId);

  @override
  String? getVkAppId() => _prefs.getString(_vkAppId);

  @override
  Future<void> clearVkAppId() async => await _prefs.remove(_vkAppId);

  /// other

  Future<void> clear() async => await _prefs.clear();
}
