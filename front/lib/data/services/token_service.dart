import 'package:front/domain/services/cache_service_interface.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:injectable/injectable.dart';

/// Сервис для управления VK токенами
@injectable
class TokenService {
  final CacheServiceInterface _cacheService;

  TokenService(this._cacheService);

  /// Сохраняет токен
  Future<void> saveToken(String token) async {
    try {
      await _cacheService.saveToken(token);
    } catch (e) {
      throw CacheException('Failed to save token: $e');
    }
  }

  /// Получает сохраненный токен
  Future<String?> getToken() async {
    try {
      return await _cacheService.getToken();
    } catch (e) {
      throw CacheException('Failed to get token: $e');
    }
  }

  /// Проверяет, есть ли токен
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Удаляет токен
  Future<void> clearToken() async {
    try {
      await _cacheService.clearToken();
    } catch (e) {
      throw CacheException('Failed to clear token: $e');
    }
  }

  /// Валидирует токен
  static bool isValidToken(String token) {
    return token.isNotEmpty && token.length > 10;
  }
}
