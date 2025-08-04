import 'dart:async';
import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:project_utils/src/exception/error_code.dart';
import 'package:project_utils/src/exception/error_extras.dart';
import 'package:project_utils/src/exception/error_type.dart';
import 'package:project_utils/src/exception/network_debug_info.dart';

class AppException extends Equatable implements Exception {
  static const String defaultMessage = 'No message provided';

  const AppException({
    ErrorType type = ErrorType.unspecified,
    this.code = ErrorCode.unspecified,
    this.extras,
    String? message,
    String? dioMessage,
    this.exception,
    this.stackTrace,
    this.networkDebugInfo,
  })  : _message = message,
        errorType = type,
        _dioMessage = dioMessage;

  /// Intended for use in `then(onError: Function(dynamic e))`,
  static AppException? fromDynamic(dynamic e, {StackTrace? st}) {
    int? statusCode;
    String? source;
    String? method;
    Map<String, dynamic>? query;
    String? data;
    if (e == null) return null;
    if (e is AppException) {
      return e;
    }
    if (e is DioException) {
      final requestBody = e.requestOptions.data;
      statusCode = e.response?.statusCode;
      source =
          '${e.requestOptions.baseUrl}${e.requestOptions.path.substring(1, e.requestOptions.path.length)}';
      method = e.requestOptions.method;
      query = e.requestOptions.queryParameters;
      if (requestBody != null) {
        if (requestBody is Map) {
          data = (e.requestOptions.data as Map<String, dynamic>).toString();
        } else if (requestBody is FormData) {
          final formDataMap = <String, dynamic>{}
            ..addEntries(requestBody.fields)
            ..addEntries(requestBody.files);
          data = formDataMap.toString();
        }
      }
    }
    return AppException(
      message: e.toString(),
      exception: e,
      stackTrace: st,
      networkDebugInfo: NetworkDebugInfo(
        statusCode: statusCode,
        source: source,
        method: method,
        query: query,
        data: data,
      ),
    );
  }

  /// Intended for use in catch(Object e)
  factory AppException.from(Object e, {StackTrace? st}) =>
      fromDynamic(e, st: st)!;

  const AppException.pure()
      : this(
          type: ErrorType.unspecified,
          code: ErrorCode.unspecified,
        );

  // Not called a type because it duplicates "type" of NetworkException
  final ErrorType errorType;
  final ErrorCode code;
  final Map<String, dynamic>? extras;
  final String? _message;
  final Object? exception;
  final StackTrace? stackTrace;
  final NetworkDebugInfo? networkDebugInfo;
  final String? _dioMessage;

  String? get message {
    String? message = _message;
    final exception = this.exception;
    if (exception is AppException) {
      message ??= exception.message;
    }
    return message;
  }

  String? get dioMessage => _dioMessage;

  String get debugJson {
    final info = <String, String?>{};
    final requestOptions = <String, String?>{};

    requestOptions
      ..['method'] = networkDebugInfo?.method
      ..['statusCode'] = networkDebugInfo?.statusCode?.toString()
      ..['url'] = networkDebugInfo?.source
      ..['query'] = networkDebugInfo?.query?.toString()
      ..['body'] = networkDebugInfo?.data;
    requestOptions.filterValues((v) => v != null).cast<String, String>();

    final options = JsonEncoder.withIndent('').convert(requestOptions);
    info
      ..['errorType'] = exception?.runtimeType.toString()
      ..['message'] = message
      ..['requestOptions'] = options
      ..['stackTrace'] = stackTrace?.toString();

    return JsonEncoder.withIndent('').convert(info);
  }

  int get externalCode => extras?[ErrorExtras.code.name] ?? 0;

  String? get externalMessage => extras?[ErrorExtras.message.name];

  bool get hasExternalMessage =>
      extras != null &&
      extras!.containsKey(ErrorExtras.message.name) &&
      (extras![ErrorExtras.message.name] as String).isNotEmpty;

  static Map<String, dynamic> codeMessageExtras(int code, [String? details]) {
    return {
      ErrorExtras.code.name: code,
      if (details != null) ErrorExtras.message.name: details,
    };
  }

  @override
  List<Object?> get props => [
        errorType,
        code,
        extras,
        _message,
        exception,
        stackTrace,
        networkDebugInfo,
      ];

  String printTrace() {
    StringBuffer sb = StringBuffer();
    sb.writeln(
      'Type: `${errorType.name}`(${code.name}). ${extras == null ? '' : 'extras $extras'} : $_message',
    );
    sb.writeln('Caused by: ${exception.toString()}');
    sb.writeln(stackTrace ?? 'Stack Track end');
    return sb.toString();
  }
}

extension NotNullOrThrowTExtension<T extends Object> on T? {
  T notNullOrThrow(Object exception) {
    final self = this;
    if (self == null) {
      throw exception;
    }
    return self;
  }
}

extension NotEmptyOrThrowStringExtension on String? {
  /// In some places '' is used as a runtime stub because a null-check exception
  /// can block user flow. The stub should be removed  when
  /// refactoring covers it.
  String notEmptyOrThrow(Object exception) {
    final self = this;
    if (self == null) {
      throw exception;
    }
    if (self.isEmpty) {
      return self;
    }
    return self;
  }
}

abstract final class ZoneUtils {
  /// Collect [E] exceptions from [provideExceptionToZone]
  /// and throws not [E] exception
  static Future<R> guardedFromErrorOfType<E extends Object, R>(
    FutureOr<R> Function() body,
    void Function(E error) onError, {
    Map<Object?, Object?>? zoneValues,
  }) {
    final completer = Completer<R>();
    runZonedGuarded(
      () async {
        final result = await body();
        completer.complete(result);
      },
      (e, s) {
        if (e is E) {
          onError(e);
        } else {
          completer.completeError(e, s);
        }
      },
      zoneValues: zoneValues,
    );
    return completer.future;
  }

  /// Provides exception to [runZonedGuarded.onError]
  static void provideExceptionToZone(Object error) {
    Zone.current.handleUncaughtError(error, StackTrace.current);
  }
}
