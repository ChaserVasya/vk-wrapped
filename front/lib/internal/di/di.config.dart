// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:front/data/services/cache_service.dart' as _i654;
import 'package:front/data/services/database_client.dart' as _i1060;
import 'package:front/data/services/export_service.dart' as _i331;
import 'package:front/data/services/token_generator.dart' as _i373;
import 'package:front/data/services/token_service.dart' as _i630;
import 'package:front/data/services/vk_api_client.dart' as _i598;
import 'package:front/data/services/vk_api_service.dart' as _i44;
import 'package:front/domain/repositories/audio_repository.dart' as _i693;
import 'package:front/domain/services/statistics_service.dart' as _i347;
import 'package:front/internal/di/module.dart' as _i90;
import 'package:front/ui/blocs/audio_bloc/audio_bloc.dart' as _i667;
import 'package:front/ui/blocs/detailed_statistics_bloc/detailed_statistics_bloc.dart'
    as _i921;
import 'package:front/ui/blocs/home_bloc/home_bloc.dart' as _i593;
import 'package:front/ui/blocs/settings_bloc/settings_bloc.dart' as _i69;
import 'package:front/ui/blocs/token_setup_bloc/token_setup_bloc.dart' as _i35;
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
    gh.lazySingleton<_i373.TokenGenerator>(() => _i373.TokenGenerator());
    gh.lazySingleton<_i654.CacheService>(() => _i654.CacheService());
    gh.lazySingleton<_i331.ExportService>(() => _i331.ExportService());
    gh.lazySingleton<_i347.StatisticsService>(() => _i347.StatisticsService());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i921.DetailedStatisticsBloc>(
      () => _i921.DetailedStatisticsBloc(
        gh<_i654.CacheService>(),
        gh<_i347.StatisticsService>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.yandexCloudClient,
      instanceName: 'yandexCloudClient',
    );
    gh.factory<_i1060.DatabaseClient>(
      () => _i1060.DatabaseClient(gh<InvalidType>()),
    );
    gh.lazySingleton<_i630.TokenService>(
      () => _i630.TokenService(gh<_i654.CacheService>()),
    );
    gh.factory<_i35.TokenSetupBloc>(
      () => _i35.TokenSetupBloc(
        tokenService: gh<_i630.TokenService>(),
        tokenGenerator: gh<_i373.TokenGenerator>(),
      ),
    );
    gh.factory<_i69.SettingsBloc>(
      () => _i69.SettingsBloc(
        cacheService: gh<_i654.CacheService>(),
        tokenService: gh<_i630.TokenService>(),
        exportService: gh<_i331.ExportService>(),
      ),
    );
    gh.lazySingleton<_i44.VkApiService>(
      () => _i44.VkApiService(
        gh<_i1060.DatabaseClient>(),
        gh<_i630.TokenService>(),
        gh<_i598.VkApiClient>(),
      ),
    );
    gh.factory<_i593.HomeBloc>(() => _i593.HomeBloc(gh<_i630.TokenService>()));
    gh.factory<_i693.AudioRepository>(
      () => _i693.AudioRepository(gh<_i44.VkApiService>()),
    );
    gh.factory<_i667.AudioBloc>(
      () => _i667.AudioBloc(
        gh<_i654.CacheService>(),
        gh<_i630.TokenService>(),
        gh<_i693.AudioRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i90.RegisterModule {}
