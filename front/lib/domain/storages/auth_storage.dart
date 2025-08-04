abstract interface class AuthStorage {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> clearToken();

  Future<void> saveVkAppId(String vkAppId);
  String? getVkAppId();
  Future<void> clearVkAppId();
}
