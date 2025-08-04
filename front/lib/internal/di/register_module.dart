import 'package:dio/dio.dart';
import 'package:front/data/services/api_client.dart';
import 'package:front/data/services/cache_service.dart';
import 'package:front/domain/services/cache_service_interface.dart'
    as cache_interface;
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  ApiClient get apiClient => ApiClient(
    dio,
    baseUrl: 'https://functions.yandexcloud.net/d4eke35eav43jvtcop7r',
  );

  @lazySingleton
  cache_interface.CacheService get cacheService => CacheService();
}
