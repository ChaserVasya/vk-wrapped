// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:front/data/services/api_client.dart' as _i1039;
import 'package:front/data/services/database_client.dart' as _i1060;
import 'package:front/data/services/enhanced_cache_service.dart' as _i703;
import 'package:front/data/services/enhanced_cache_service_new.dart' as _i947;
import 'package:front/data/services/token_service.dart' as _i630;
import 'package:front/data/services/vk_api_service.dart' as _i44;
import 'package:front/domain/repositories/audio_repository.dart' as _i693;
import 'package:front/domain/services/cache_service_interface.dart' as _i384;
import 'package:front/domain/services/enhanced_statistics_service.dart'
    as _i742;
import 'package:front/domain/use_cases/get_audio_tracks_use_case.dart' as _i799;
import 'package:front/domain/use_cases/get_user_audio_use_case.dart' as _i65;
import 'package:front/internal/di/register_module.dart' as _i121;
import 'package:front/ui/blocs/audio_bloc/audio_bloc.dart' as _i667;
import 'package:front/ui/blocs/detailed_statistics_bloc/detailed_statistics_bloc.dart'
    as _i921;
import 'package:front/ui/blocs/home_bloc/home_bloc.dart' as _i593;
import 'package:front/ui/blocs/settings_bloc/settings_bloc.dart' as _i69;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i703.EnhancedCacheService>(() => _i703.EnhancedCacheService());
    gh.factory<_i947.EnhancedCacheService>(() => _i947.EnhancedCacheService());
    gh.factory<_i742.EnhancedStatisticsService>(
      () => _i742.EnhancedStatisticsService(),
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i1039.ApiClient>(() => registerModule.apiClient);
    gh.lazySingleton<_i384.CacheServiceInterface>(
      () => registerModule.cacheService,
    );
    gh.lazySingleton<_i693.AudioRepository>(
      () => registerModule.audioRepository,
    );
    gh.factory<_i1060.DatabaseClient>(
      () => _i1060.DatabaseClient(gh<_i1039.ApiClient>()),
    );
    gh.factory<_i65.GetUserAudioUseCase>(
      () => _i65.GetUserAudioUseCase(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i799.GetAudioTracksUseCase>(
      () => _i799.GetAudioTracksUseCase(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i921.DetailedStatisticsBloc>(
      () => _i921.DetailedStatisticsBloc(gh<_i384.CacheServiceInterface>()),
    );
    gh.factory<_i630.TokenService>(
      () => _i630.TokenService(gh<_i384.CacheServiceInterface>()),
    );
    gh.lazySingleton<_i667.AudioBloc>(
      () => _i667.AudioBloc(
        gh<_i799.GetAudioTracksUseCase>(),
        gh<_i65.GetUserAudioUseCase>(),
        gh<_i384.CacheServiceInterface>(),
      ),
    );
    gh.factory<_i69.SettingsBloc>(
      () => _i69.SettingsBloc(
        cacheService: gh<_i384.CacheServiceInterface>(),
        tokenService: gh<_i630.TokenService>(),
      ),
    );
    gh.factory<_i44.VkApiService>(
      () => _i44.VkApiService(gh<_i1060.DatabaseClient>()),
    );
    gh.factory<_i593.HomeBloc>(
      () => _i593.HomeBloc(tokenService: gh<_i630.TokenService>()),
    );
    gh.factory<_i693.AudioRepositoryImpl>(
      () => _i693.AudioRepositoryImpl(gh<_i44.VkApiService>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i121.RegisterModule {}
