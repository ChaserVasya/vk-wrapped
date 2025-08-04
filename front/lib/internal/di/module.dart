import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const ycClient = Named('yandexCloudClient');

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @ycClient
  @lazySingleton
  Dio get yandexCloudClient => Dio(
    BaseOptions(
      baseUrl: 'https://functions.yandexcloud.net/d4eke35eav43jvtcop7r',
    ),
  );
}
