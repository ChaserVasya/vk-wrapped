import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:front/data/services/api_client.dart';

import 'package:front/domain/services/cache_service_interface.dart';
import 'package:front/data/services/enhanced_cache_service.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/data/services/vk_api_service.dart';
import 'package:front/data/services/database_client.dart';
import 'package:front/ui/blocs/audio_bloc/audio_bloc.dart';
import 'package:front/domain/use_cases/get_audio_tracks_use_case.dart';
import 'package:front/domain/use_cases/get_user_audio_use_case.dart';

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
  CacheServiceInterface get cacheService => EnhancedCacheService();

  @lazySingleton
  AudioRepository get audioRepository =>
      AudioRepositoryImpl(VkApiService(DatabaseClient(apiClient)));
}
