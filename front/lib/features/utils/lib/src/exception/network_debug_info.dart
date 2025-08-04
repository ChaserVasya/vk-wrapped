import 'package:equatable/equatable.dart';

class NetworkDebugInfo extends Equatable {
  const NetworkDebugInfo({
    this.statusCode,
    this.source,
    this.method,
    this.query,
    this.data,
  });

  final int? statusCode;
  final String? source;
  final String? method;
  final Map<String, dynamic>? query;
  final String? data;

  @override
  List<Object?> get props => [
        statusCode,
        source,
        method,
        query,
        data,
      ];
}
