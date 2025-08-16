import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/services/app_info_service.dart';
import 'package:injectable/injectable.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio()
    ..interceptors.addAll([
      _cacheInterceptor,
      _vkResponseErrorInterceptor,
      PrettyDioLogger(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
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

  @lazySingleton
  QueryExecutor get drift => driftDatabase(name: 'app_database');

  @lazySingleton
  SharePlus get sharePlus => SharePlus.instance;

  @lazySingleton
  AppInfoService get appInfoService => AppInfoServiceImpl();
}

final _cacheInterceptor = DioCacheInterceptor(
  options: CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    hitCacheOnErrorExcept: [401, 403],
    maxStale: const Duration(seconds: 30),
    priority: CachePriority.normal,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  ),
);

final _errorMappingInterceptor = InterceptorsWrapper(
  onError: (error, handler) {
    final inner = error.error;
    if (inner is AppException) {
      throw inner;
    }
    throw AppException.from(error);
  },
);

final _vkResponseErrorInterceptor = InterceptorsWrapper(
  onResponse: (response, handler) {
    try {
      final baseUrl = response.requestOptions.baseUrl;
      final isVk = baseUrl.contains('api.vk.com');
      final data = response.data;
      if (isVk && data is Map) {
        final map = Map<String, dynamic>.from(data);
        if (map.containsKey('error')) {
          final vkError = VkErrorResponse.fromJson(map).error;
          if (vkError.errorCode == 5) {
            throw const VkAuthFailedException();
          } else {
            throw AppException(
              vkError.errorMsg,
              code: 'VK_${vkError.errorCode}',
              originalError: vkError,
            );
          }
        }
      }
      handler.next(response);
    } catch (e, st) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: AppException.from(e, st: st),
        ),
      );
    }
  },
);
