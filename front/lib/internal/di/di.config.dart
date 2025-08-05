// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:drift/drift.dart' as _i500;
import 'package:front/data/local/audio_storage/audio_storage.dart' as _i309;
import 'package:front/data/local/audio_storage/drift/database.dart' as _i657;
import 'package:front/data/local/audio_storage/drift/drift_audio_storage.dart'
    as _i254;
import 'package:front/data/local/export_service.dart' as _i1056;
import 'package:front/data/local/prefs_storage.dart' as _i34;
import 'package:front/data/remote/api/track_sessions_client.dart' as _i537;
import 'package:front/data/remote/api/vk_api_client.dart' as _i543;
import 'package:front/data/remote/services/vk_service.dart' as _i988;
import 'package:front/domain/repositories/audio_repository.dart' as _i693;
import 'package:front/domain/services/first_launch_service.dart' as _i562;
import 'package:front/domain/services/statistics_service.dart' as _i347;
import 'package:front/domain/services/token_generator.dart' as _i458;
import 'package:front/domain/storages/auth_storage.dart' as _i297;
import 'package:front/internal/di/module.dart' as _i90;
import 'package:front/ui/blocs/albums_cubit.dart' as _i77;
import 'package:front/ui/blocs/albums_with_artists_cubit.dart' as _i868;
import 'package:front/ui/blocs/artists_cubit.dart' as _i567;
import 'package:front/ui/blocs/genres_cubit.dart' as _i977;
import 'package:front/ui/blocs/settings_bloc/settings_bloc.dart' as _i69;
import 'package:front/ui/blocs/statistics_bloc/statistics_bloc.dart' as _i58;
import 'package:front/ui/blocs/token_setup_bloc/token_setup_bloc.dart' as _i35;
import 'package:front/ui/blocs/tracks_cubit.dart' as _i308;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:share_plus/share_plus.dart' as _i998;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i347.StatisticsService>(() => _i347.StatisticsService());
    gh.factory<_i562.FirstLaunchService>(() => _i562.FirstLaunchService());
    await gh.singletonAsync<_i460.SharedPreferencesWithCache>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i500.QueryExecutor>(() => registerModule.drift);
    gh.lazySingleton<_i998.SharePlus>(() => registerModule.sharePlus);
    gh.lazySingleton<_i458.TokenGenerator>(() => _i458.TokenGenerator());
    gh.lazySingleton<_i657.AppDatabase>(
      () => _i657.AppDatabase(gh<_i500.QueryExecutor>()),
    );
    gh.lazySingleton<_i34.PrefsStorage>(
      () => registerModule.prefsStorage(gh<_i460.SharedPreferencesWithCache>()),
    );
    gh.lazySingleton<_i537.TrackSessionsClient>(
      () => _i537.TrackSessionsClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i543.VkApiClient>(
      () => _i543.VkApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i988.VkService>(
      () => _i988.VkService(gh<_i34.PrefsStorage>(), gh<_i543.VkApiClient>()),
    );
    gh.lazySingleton<_i1056.ExportService>(
      () => _i1056.ExportService(gh<_i998.SharePlus>()),
    );
    gh.lazySingleton<_i297.AuthStorage>(
      () => _i34.PrefsStorage(gh<_i460.SharedPreferencesWithCache>()),
    );
    gh.lazySingleton<_i309.AudioStorage>(
      () => _i254.DriftAudioStorage(gh<_i657.AppDatabase>()),
    );
    gh.factory<_i35.TokenSetupBloc>(
      () => _i35.TokenSetupBloc(
        gh<_i297.AuthStorage>(),
        gh<_i458.TokenGenerator>(),
      ),
    );
    gh.factory<_i693.AudioRepository>(
      () => _i693.AudioRepository(
        gh<_i988.VkService>(),
        gh<_i309.AudioStorage>(),
        gh<_i537.TrackSessionsClient>(),
      ),
    );
    gh.factory<_i69.SettingsBloc>(
      () => _i69.SettingsBloc(
        gh<_i34.PrefsStorage>(),
        gh<_i693.AudioRepository>(),
        gh<_i1056.ExportService>(),
        gh<_i297.AuthStorage>(),
      ),
    );
    gh.factory<_i308.TracksCubit>(
      () => _i308.TracksCubit(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i77.AlbumsCubit>(
      () => _i77.AlbumsCubit(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i567.ArtistsCubit>(
      () => _i567.ArtistsCubit(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i977.GenresCubit>(
      () => _i977.GenresCubit(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i868.AlbumsWithArtistsCubit>(
      () => _i868.AlbumsWithArtistsCubit(gh<_i693.AudioRepository>()),
    );
    gh.factory<_i58.StatisticsBloc>(
      () => _i58.StatisticsBloc(
        gh<_i347.StatisticsService>(),
        gh<_i693.AudioRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i90.RegisterModule {}
