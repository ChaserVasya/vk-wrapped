import 'package:dio/dio.dart';
import 'package:front/data/remote/api/tracks_real_data.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'generated/track_sessions_client.g.dart';

@lazySingleton
@RestApi(baseUrl: 'https://functions.yandexcloud.net/d4eke35eav43jvtcop7r')
abstract class TrackSessionsClient {
  @factoryMethod
  factory TrackSessionsClient(Dio dio) = _TrackSessionsClient;

  @GET('/')
  Future<List<TrackSession>> getSessions();
}
