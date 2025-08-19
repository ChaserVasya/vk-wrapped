import 'package:dio/dio.dart';
import 'package:front/domain/entities/meme_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/meme_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: 'https://functions.yandexcloud.net/d4e6hpd53ojo7gunik8h')
abstract class MemeApiClient {
  @factoryMethod
  factory MemeApiClient(Dio dio) = _MemeApiClient;

  @GET('/')
  Future<MemeResponse> getMeme();

  @POST('/')
  Future<void> toggleMemeLike({@Query('meme_id') required String memeId});

  @GET('/')
  Future<List<String>> getLikedMemes({
    @Query('action') String action = 'likes',
  });
}
