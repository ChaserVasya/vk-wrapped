import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

/// Генератор VK Personal Token
@lazySingleton
class TokenGenerator {
  static const IListConst<String> _scopes = IListConst(['audio', 'offline']);

  String generateAuthUrl(String clientId) {
    const redirectUri = 'https://oauth.vk.com/blank.html';

    final scopesParam = _scopes.join(',');
    return 'https://oauth.vk.com/authorize?'
        'client_id=$clientId&'
        'display=page&'
        'redirect_uri=$redirectUri&'
        'scope=$scopesParam&'
        'response_type=token&'
        'v=5.131';
  }

  String? extractTokenFromUrl(String url) {
    final uri = Uri.parse(url);
    final queryParams = uri.queryParameters;
    return queryParams['access_token'];
  }
}
