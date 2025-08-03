import 'dart:io';

/// Генератор VK Personal Token для профиля isaykinvasya
/// 
/// Захардкоженные значения для быстрого получения токена
class VkTokenGenerator {
  /// ID приложения VK (Client ID) - пробуем другой ID
  static const String _consumerAppId = '3140623'; // VK приложение
  
  /// Версия VK API
  static const String _apiVersion = '5.131';
  
  /// Права доступа для отслеживания музыки
  static const List<String> _scopes = [
    'status', // Доступ к статусу пользователя
    'offline', // Доступ к API в любое время
  ];
  
  /// Redirect URI после авторизации
  static const String _redirectUri = 'https://oauth.vk.com/blank.html';
  
  /// Базовый URL для авторизации VK
  static const String _authUrl = 'https://oauth.vk.com/authorize';
  
  /// Генерирует ссылку для получения personal token
  static String generateTokenUrl() {
    final scopesString = _scopes.join(',');
    
    final queryParams = {
      'client_id': _consumerAppId,
      'display': 'page',
      'redirect_uri': _redirectUri,
      'scope': scopesString,
      'response_type': 'token',
      'v': _apiVersion,
    };
    
    final queryString = queryParams.entries
        .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
        .join('&');
    
    return '$_authUrl?$queryString';
  }
  
  /// Выводит инструкции по использованию
  static void printInstructions() {
    print('''
🔗 VK Personal Token Generator для isaykinvasya
===============================================

📋 Инструкция по получению токена:

1. Скопируйте ссылку ниже
2. Откройте её в браузере
3. Авторизуйтесь в VK и разрешите доступ приложению
4. Скопируйте токен из адресной строки браузера
   (он будет после access_token= и до &)
5. Используйте токен в переменных окружения:
   SERVICE_TOKEN=ваш_токен

⚠️  ВАЖНО: 
- Токен имеет ограниченный срок действия
- Храните токен в безопасном месте
- Не публикуйте токен в открытом доступе

🔗 Ссылка для получения токена:
''');
  }
  
  /// Основная функция
  static void main() {
    printInstructions();
    
    final tokenUrl = generateTokenUrl();
    print(tokenUrl);
    print('');
    print('📋 Скопируйте ссылку выше и откройте в браузере');
  }
}

/// Точка входа
void main() {
  VkTokenGenerator.main();
} 