import 'package:flutter/material.dart';

class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppException(this.message, {this.stackTrace});

  @override
  String toString() => message;
}

class TranslatedAppException extends AppException {
  final String Function(BuildContext context) translatedMessage;

  TranslatedAppException(super.message, {required this.translatedMessage});

  String getTranslatedMessage(BuildContext context) =>
      translatedMessage(context);
}

class NetworkException extends AppException {
  final String? dioMessage;
  final dynamic sourceError;

  NetworkException(super.message, {this.dioMessage, this.sourceError});

  String get debugJson => '{"error": "$message", "dioMessage": "$dioMessage"}';
}
