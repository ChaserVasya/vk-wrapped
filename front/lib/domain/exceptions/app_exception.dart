/// Базовый класс для исключений приложения
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  @override
  String toString() {
    return 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
  }
}

/// Исключение для сетевых ошибок
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.originalError});
}

/// Исключение для ошибок API
class ApiException extends AppException {
  const ApiException(super.message, {super.code, super.originalError});
}

/// Исключение для ошибок кэша
class CacheException extends AppException {
  const CacheException(super.message, {super.code, super.originalError});
}
