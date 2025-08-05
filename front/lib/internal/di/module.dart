import 'package:dio/dio.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/services/statistics_service.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio()
    ..interceptors.addAll([
      PrettyDioLogger(responseBody: true, requestBody: true),
      _errorMappingInterceptor,
    ]);

  @singleton
  @preResolve
  Future<SharedPreferencesWithCache> get prefs =>
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );

  @lazySingleton
  PrefsStorage prefsStorage(SharedPreferencesWithCache prefs) =>
      PrefsStorage(prefs);

  @injectable
  StatisticsBloc statisticsBloc(StatisticsService statisticsService) =>
      StatisticsBloc(statisticsService);
}

final _errorMappingInterceptor = InterceptorsWrapper(
  onError: (error, handler) {
    throw NetworkException(error.toString(), originalError: error);
  },
);
