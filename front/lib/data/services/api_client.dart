import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/')
  Future<DatabaseResponse> getUserSessions();
}

@JsonSerializable()
class DatabaseResponse {
  final List<Map<String, dynamic>> currentSessions;
  final List<Map<String, dynamic>> completedSessions;

  DatabaseResponse({
    required this.currentSessions,
    required this.completedSessions,
  });

  factory DatabaseResponse.fromJson(Map<String, dynamic> json) =>
      _$DatabaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DatabaseResponseToJson(this);
}
