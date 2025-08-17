import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

  /// Создает AppException из любого объекта с автоматическим определением типа
  factory AppException.from(Object error, {StackTrace? st}) {
    if (error is AppException) return error;

    // Если это DioException, проверяем error поле
    if (error is DioException && error.error is AppException) {
      return error.error as AppException;
    }

    final message = error.toString();
    return AppException(
      message,
      originalError: error,
      st: st ?? StackTrace.current,
    );
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

/// Исключение для отсутствия токена
class NoTokenException extends AppException {
  const NoTokenException() : super('VK Token отсутствует');
}

class VkAuthFailedException extends AppException {
  const VkAuthFailedException()
    : super('Токен истёк или не одобрен', code: 'VK_AUTH_FAILED');
}

/// Исключение для недоступных аудио
class VkAudioUnavailableException extends AppException {
  const VkAudioUnavailableException(String audioId)
    : super('Аудио недоступно: $audioId', code: 'VK_AUDIO_UNAVAILABLE');
}
