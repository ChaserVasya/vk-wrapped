import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const ycClient = Named('yandexCloudClient');

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @singleton
  @preResolve
  Future<SharedPreferencesWithCache> get prefs =>
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          // This cache will only accept the key 'counter'.
          allowList: <String>{'counter'},
        ),
      );
}
