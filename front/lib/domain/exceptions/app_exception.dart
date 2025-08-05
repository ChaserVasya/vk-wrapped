import 'package:flutter/material.dart';

/// Базовый класс для исключений приложения
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? st;

  const AppException(this.message, {this.code, this.originalError, this.st});

  @override
  String toString() {
    return 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
  }

  /// Создает AppException с текущим стектрейсом
  factory AppException.withStackTrace(
    String message, {
    String? code,
    dynamic originalError,
    StackTrace? st,
  }) {
    return AppException(
      message,
      code: code,
      originalError: originalError,
      st: st ?? StackTrace.current,
    );
  }

  /// Создает AppException из динамического объекта
  factory AppException.fromDynamic(dynamic error, {StackTrace? st}) {
    if (error is AppException) return error;

    final message = error?.toString() ?? 'Unknown error';
    return AppException.withStackTrace(
      message,
      originalError: error,
      st: st ?? StackTrace.current,
    );
  }

  /// Возвращает JSON для дебага
  String get debugJson {
    return '''
{
  "message": "$message",
  "code": "${code ?? 'null'}",
  "originalError": "${originalError?.toString() ?? 'null'}",
  "st": "${st?.toString() ?? 'null'}"
}
''';
  }

  /// Возвращает информацию для дебага
  String get debugInfo {
    final buffer = StringBuffer();
    buffer.writeln('Message: $message');
    if (code != null) buffer.writeln('Code: $code');
    if (originalError != null) buffer.writeln('Original Error: $originalError');
    if (st != null) buffer.writeln('Stack Trace:\n$st');
    return buffer.toString();
  }

  /// Создает сообщение для UI
  String constructMessageInUI(BuildContext context, AppException error) {
    return error.message;
  }
}

/// Исключение для сетевых ошибок
class NetworkException extends AppException {
  final String? dioMessage;
  final NetworkDebugInfo? networkDebugInfo;

  const NetworkException(
    super.message, {
    super.code,
    super.originalError,
    super.st,
    this.dioMessage,
    this.networkDebugInfo,
  });

  factory NetworkException.withStackTrace(
    String message, {
    String? code,
    dynamic originalError,
    StackTrace? st,
    String? dioMessage,
    NetworkDebugInfo? networkDebugInfo,
  }) {
    return NetworkException(
      message,
      code: code,
      originalError: originalError,
      st: st ?? StackTrace.current,
      dioMessage: dioMessage,
      networkDebugInfo: networkDebugInfo,
    );
  }

  @override
  String get debugJson {
    return '''
{
  "message": "$message",
  "code": "${code ?? 'null'}",
  "originalError": "${originalError?.toString() ?? 'null'}",
  "st": "${st?.toString() ?? 'null'}",
  "dioMessage": "${dioMessage ?? 'null'}",
  "networkDebugInfo": ${networkDebugInfo?.toJson() ?? 'null'}
}
''';
  }
}

/// Исключение для ошибок API
class ApiException extends AppException {
  const ApiException(
    super.message, {
    super.code,
    super.originalError,
    super.st,
  });

  factory ApiException.withStackTrace(
    String message, {
    String? code,
    dynamic originalError,
    StackTrace? st,
  }) {
    return ApiException(
      message,
      code: code,
      originalError: originalError,
      st: st ?? StackTrace.current,
    );
  }
}

/// Исключение для ошибок кэша
class CacheException extends AppException {
  const CacheException(
    super.message, {
    super.code,
    super.originalError,
    super.st,
  });

  factory CacheException.withStackTrace(
    String message, {
    String? code,
    dynamic originalError,
    StackTrace? st,
  }) {
    return CacheException(
      message,
      code: code,
      originalError: originalError,
      st: st ?? StackTrace.current,
    );
  }
}

/// Информация для дебага сетевых запросов
class NetworkDebugInfo {
  final int? statusCode;
  final String? method;
  final String? source;
  final String? query;
  final String? data;

  const NetworkDebugInfo({
    this.statusCode,
    this.method,
    this.source,
    this.query,
    this.data,
  });

  String? toJson() {
    return '''
{
  "statusCode": $statusCode,
  "method": "$method",
  "source": "$source",
  "query": "$query",
  "data": "$data"
}
''';
  }
}
