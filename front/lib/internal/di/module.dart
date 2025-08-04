import 'package:dio/dio.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio()
    ..interceptors.add(PrettyDioLogger(responseBody: true, requestBody: true));

  @singleton
  @preResolve
  Future<SharedPreferencesWithCache> get prefs =>
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );

  @lazySingleton
  PrefsStorage prefsStorage(SharedPreferencesWithCache prefs) =>
      PrefsStorage(prefs);
}
