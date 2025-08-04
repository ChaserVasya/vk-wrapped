import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'generated/track_sessions_client.g.dart';

@RestApi(baseUrl: 'https://functions.yandexcloud.net/d4eke35eav43jvtcop7r')
abstract class TrackSessionsClient {
  factory TrackSessionsClient(Dio dio, {String? baseUrl}) =
      _TrackSessionsClient;

  @GET('/')
  Future<IList<TrackSession>> getSessions();
}
