abstract interface class AuthStorage {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> clearToken();
  Future<void> saveTokenExpiry(DateTime? expiresAt);
  DateTime? getTokenExpiry();

  Future<void> saveVkAppId(String vkAppId);
  String? getVkAppId();
  Future<void> clearVkAppId();
}
