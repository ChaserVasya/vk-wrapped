/// Конфигурация VK API доменов и URL
abstract final class VkConfig {
  /// Базовый домен для VK API
  static const String apiDomain = 'api.vk.ru';

  /// Базовый домен для VK OAuth
  static const String oauthDomain = 'oauth.vk.ru';

  /// Базовый URL для VK API
  static const String apiBaseUrl = 'https://$apiDomain/method';

  /// URL для авторизации VK
  static const String oauthAuthorizeUrl = 'https://$oauthDomain/authorize';

  /// Redirect URI для OAuth
  static const String oauthRedirectUri = 'https://$oauthDomain/blank.html';

  /// Версия VK API
  static const String apiVersion = '5.131';
}
