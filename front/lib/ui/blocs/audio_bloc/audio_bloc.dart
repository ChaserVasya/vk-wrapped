import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/services/cache_service.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/use_cases/get_audio_tracks_use_case.dart';
import 'package:front/domain/use_cases/get_user_audio_use_case.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:injectable/injectable.dart';

part 'audio_bloc.freezed.dart';

// Events
@freezed
sealed class AudioEvent with _$AudioEvent {
  const factory AudioEvent.loadUserAudio({int? count}) = _LoadUserAudio;
  const factory AudioEvent.loadAudioTracks({required IList<String> trackIds}) =
      _LoadAudioTracks;
  const factory AudioEvent.setToken({required String token}) = _SetToken;
  const factory AudioEvent.clearCache() = _ClearCache;
}

// States
@freezed
class AudioState with _$AudioState {
  const factory AudioState({
    @Default(CommonStates.loading()) CommonStates<IList<AudioTrack>> tracks,
    @Default(CommonStates.loading()) CommonStates<String> token,
  }) = _AudioState;
}

// BLoC
@injectable
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc(this._cacheService, this._tokenService, this._audioRepository)
    : super(const AudioState()) {
    on<_LoadUserAudio>(_onLoadUserAudio);
    on<_LoadAudioTracks>(_onLoadAudioTracks);
    on<_SetToken>(_onSetToken);
    on<_ClearCache>(_onClearCache);
  }

  final AudioRepository _audioRepository;
  final CacheService _cacheService;
  final TokenService _tokenService;

  FutureOr<void> _onLoadUserAudio(
    _LoadUserAudio event,
    Emitter<AudioState> emit,
  ) async {
    print('🔄 AudioBloc: _onLoadUserAudio called');
    emit(
      state.copyWith(tracks: const CommonStates<IList<AudioTrack>>.loading()),
    );
    print('🔄 AudioBloc: Emitted loading state');

    try {
      print('🔄 AudioBloc: Calling _getUserAudioUseCase');
      final tracks = await _audioRepository.getUserAudio(
        count: event.count ?? 50,
      );
      print('🔄 AudioBloc: Got ${tracks.length} tracks');
      await _cacheService.cacheTracks(tracks);

      emit(
        state.copyWith(tracks: CommonStates<IList<AudioTrack>>.data(tracks)),
      );
      print('🔄 AudioBloc: Emitted data state');
    } catch (e) {
      print('❌ AudioBloc: Error occurred: $e');
      emit(
        state.copyWith(
          tracks: CommonStates<IList<AudioTrack>>.error(
            AppException(e.toString()),
          ),
        ),
      );
      print('🔄 AudioBloc: Emitted error state');
    }
  }

  FutureOr<void> _onLoadAudioTracks(
    _LoadAudioTracks event,
    Emitter<AudioState> emit,
  ) async {
    emit(
      state.copyWith(tracks: const CommonStates<IList<AudioTrack>>.loading()),
    );

    try {
      final tracks = await _audioRepository.getAudioById(event.trackIds);
      await _cacheService.cacheTracks(tracks);

      emit(
        state.copyWith(tracks: CommonStates<IList<AudioTrack>>.data(tracks)),
      );
    } catch (e) {
      emit(
        state.copyWith(
          tracks: CommonStates<IList<AudioTrack>>.error(
            AppException(e.toString()),
          ),
        ),
      );
    }
  }

  FutureOr<void> _onSetToken(_SetToken event, Emitter<AudioState> emit) async {
    try {
      await _tokenService.saveToken(event.token);
      emit(state.copyWith(token: CommonStates<String>.data(event.token)));
    } catch (e) {
      emit(
        state.copyWith(
          token: CommonStates<String>.error(AppException(e.toString())),
        ),
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
