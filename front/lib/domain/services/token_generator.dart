import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:front/domain/config/vk_config.dart';

/// Генератор VK Personal Token
@lazySingleton
class TokenGenerator {
  static const IListConst<String> _scopes = IListConst(['audio', 'offline']);

  String generateAuthUrl(String clientId) {
    final scopesParam = _scopes.join(',');
    return '${VkConfig.oauthAuthorizeUrl}?'
        'client_id=$clientId&'
        'display=page&'
        'redirect_uri=${VkConfig.oauthRedirectUri}&'
        'scope=$scopesParam&'
        'response_type=token&'
        'v=${VkConfig.apiVersion}';
  }

  String? extractTokenFromUrl(String url) {
    final uri = Uri.parse(url);

    // Проверяем query параметры (для старых форматов)
    final queryParams = uri.queryParameters;
    final tokenFromQuery = queryParams['access_token'];
    if (tokenFromQuery != null) {
      return tokenFromQuery;
    }

    // Проверяем фрагмент URL (после #)
    final fragment = uri.fragment;
    if (fragment.isNotEmpty) {
      final fragmentParams = Uri.splitQueryString(fragment);
      return fragmentParams['access_token'];
    }

    return null;
  }

  DateTime? extractExpiryFromUrl(String url) {
    final uri = Uri.parse(url);

    final queryParams = uri.queryParameters;
    final expiresQuery = queryParams['expires_in'];
    if (expiresQuery != null) {
      final seconds = int.tryParse(expiresQuery);
      if (seconds != null && seconds > 0) {
        return DateTime.now().add(Duration(seconds: seconds));
      }
      if (seconds == 0) return null; // 0 = offline token (no expiry)
    }

    final fragment = uri.fragment;
    if (fragment.isNotEmpty) {
      final fragmentParams = Uri.splitQueryString(fragment);
      final expires = fragmentParams['expires_in'];
      if (expires != null) {
        final seconds = int.tryParse(expires);
        if (seconds != null && seconds > 0) {
          return DateTime.now().add(Duration(seconds: seconds));
        }
        if (seconds == 0) return null;
      }
    }

    return null;
  }
}
