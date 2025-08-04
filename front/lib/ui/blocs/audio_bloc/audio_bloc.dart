import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/use_cases/get_audio_tracks_use_case.dart';
import 'package:front/domain/use_cases/get_user_audio_use_case.dart';
import 'package:front/domain/services/cache_service_interface.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/domain/exceptions/app_exception.dart';

part 'audio_bloc.freezed.dart';

// Events
@freezed
sealed class AudioEvent with _$AudioEvent {
  const factory AudioEvent.loadUserAudio({int? count}) = _LoadUserAudio;
  const factory AudioEvent.loadAudioTracks({required List<String> trackIds}) =
      _LoadAudioTracks;
  const factory AudioEvent.setToken({required String token}) = _SetToken;
  const factory AudioEvent.clearCache() = _ClearCache;
}

// States
@freezed
class AudioState with _$AudioState {
  AudioState({
    this.tracks = const CommonStates.loading(),
    this.token = const CommonStates.loading(),
  });

  @override
  final CommonStates<List<AudioTrack>> tracks;
  @override
  final CommonStates<String> token;
}

// BLoC
@injectable
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc(
    this._getAudioTracksUseCase,
    this._getUserAudioUseCase,
    this._cacheService,
  ) : super(AudioState()) {
    on<_LoadUserAudio>(_onLoadUserAudio);
    on<_LoadAudioTracks>(_onLoadAudioTracks);
    on<_SetToken>(_onSetToken);
    on<_ClearCache>(_onClearCache);
  }

  final GetAudioTracksUseCase _getAudioTracksUseCase;
  final GetUserAudioUseCase _getUserAudioUseCase;
  final CacheServiceInterface _cacheService;

  FutureOr<void> _onLoadUserAudio(
    _LoadUserAudio event,
    Emitter<AudioState> emit,
  ) async {
    emit(state.copyWith(tracks: const CommonStates.loading()));

    try {
      final tracks = await _getUserAudioUseCase(count: event.count ?? 50);
      await _cacheService.cacheTracks(tracks);

      emit(state.copyWith(tracks: CommonStates.data(tracks)));
    } catch (e) {
      emit(
        state.copyWith(tracks: CommonStates.error(AppException(e.toString()))),
      );
    }
  }

  FutureOr<void> _onLoadAudioTracks(
    _LoadAudioTracks event,
    Emitter<AudioState> emit,
  ) async {
    emit(state.copyWith(tracks: const CommonStates.loading()));

    try {
      final tracks = await _getAudioTracksUseCase(event.trackIds);
      await _cacheService.cacheTracks(tracks);

      emit(state.copyWith(tracks: CommonStates.data(tracks)));
    } catch (e) {
      emit(
        state.copyWith(tracks: CommonStates.error(AppException(e.toString()))),
      );
    }
  }

  FutureOr<void> _onSetToken(_SetToken event, Emitter<AudioState> emit) async {
    try {
      await _cacheService.saveToken(event.token);
      emit(state.copyWith(token: CommonStates.data(event.token)));
    } catch (e) {
      emit(
        state.copyWith(token: CommonStates.error(AppException(e.toString()))),
      );
    }
  }

  FutureOr<void> _onClearCache(
    _ClearCache event,
    Emitter<AudioState> emit,
  ) async {
    try {
      await _cacheService.clearCache();
    } catch (e) {
      // Handle error silently for cache clearing
    }
  }
}
