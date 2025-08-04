import 'package:front/data/services/cache_service.dart';
import 'package:injectable/injectable.dart';

/// Сервис для управления VK токенами
@lazySingleton
class TokenService {
  final CacheService _cacheService;

  TokenService(this._cacheService);

  /// Сохраняет токен
  Future<void> saveToken(String token) async {
    await _cacheService.saveToken(token);
  }

  /// Получает сохраненный токен
  Future<String?> getToken() async {
    return await _cacheService.getToken();
  }

  /// Проверяет, есть ли токен
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Удаляет токен
  Future<void> clearToken() async {
    await _cacheService.clearToken();
  }

  /// Валидирует токен
  bool isValidToken(String token) {
    return token.isNotEmpty && token.length > 10;
  }

  /// Получает clientId (извлекает из токена или возвращает дефолтный)
  Future<String> getClientId() async {
    // Пытаемся получить из кэша
    final cachedClientId = await _cacheService.getClientId();
    if (cachedClientId != null && cachedClientId.isNotEmpty) {
      return cachedClientId;
    }

    // Если нет в кэше, возвращаем дефолтный VK client ID
    return '51729127'; // VK Wrapped App ID
  }

  /// Устанавливает clientId
  Future<void> setClientId(String clientId) async {
    await _cacheService.saveClientId(clientId);
  }
}
