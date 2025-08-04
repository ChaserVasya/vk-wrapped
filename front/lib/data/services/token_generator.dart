import 'package:injectable/injectable.dart';

/// Генератор VK Personal Token
@lazySingleton
class TokenGenerator {
  static const String _clientId = '6121396';
  static const String _apiVersion = '5.131';
  static const List<String> _scopes = ['audio', 'offline'];
  static const String _redirectUri = 'https://oauth.vk.com/blank.html';
  static const String _authUrl = 'https://oauth.vk.com/authorize';

  /// Генерирует URL для получения VK Personal Token
  String generateTokenUrl() {
    final scopesParam = _scopes.join(',');

    final params = {
      'client_id': _clientId,
      'display': 'page',
      'redirect_uri': _redirectUri,
      'scope': scopesParam,
      'response_type': 'token',
      'v': _apiVersion,
    };

    final uri = Uri.parse(_authUrl).replace(queryParameters: params);
    return uri.toString();
  }
}
