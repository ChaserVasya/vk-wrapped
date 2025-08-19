import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/local/export_service.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/storages/auth_storage.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:injectable/injectable.dart';

part 'settings_bloc.freezed.dart';
part 'settings_effect.dart';
part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends EffectBloc<SettingsEvent, SettingsState> {
  final PrefsStorage _cacheService;
  final AudioRepository _audioRepository;
  final ExportService _exportService;
  final AuthStorage _authStorage;

  SettingsBloc(
    this._cacheService,
    this._audioRepository,
    this._exportService,
    this._authStorage,
  ) : super(const CommonStates.loading()) {
    on<_ClearToken>(_onClearToken);
    on<_SaveToken>(_onSaveToken);
    on<_ClearCache>(_onClearCache);
    on<_ExportData>(_onExportData);
    on<_LoadCurrentData>(_onLoadCurrentData);
  }

  Future<void> _doIfData(
    Future<void> Function(SettingsData data, Emitter<SettingsState> emit)
    action,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CommonStateData<SettingsData>) {
      return;
    }

    emit(const CommonStates.loading());
    try {
      await action(currentState.ensureData, emit);
    } catch (e, s) {
      emitErrorEffect(e, st: s);
      // В случае ошибки эмитим error состояние
      emit(CommonStates.error(AppException.from(e, st: s)));
    }
  }

  Future<void> _onClearToken(
    _ClearToken event,
    Emitter<SettingsState> emit,
  ) async {
    await _doIfData((data, emit) async {
      await _cacheService.clearToken();
      await _cacheService.saveTokenExpiry(null);
      emit(
        CommonStates.data(
          data.copyWith(
            hasToken: false,
            currentToken: null,
            tokenExpiresAt: null,
          ),
        ),
      );
      emitEffect(const SettingsEffect.tokenCleared());
    }, emit);
  }

  Future<void> _onSaveToken(
    _SaveToken event,
    Emitter<SettingsState> emit,
  ) async {
    await _doIfData((data, emit) async {
      await _authStorage.saveToken(event.token);
      emit(
        CommonStates.data(
          data.copyWith(hasToken: true, currentToken: event.token),
        ),
      );
      emitEffect(const SettingsEffect.tokenSaved());
    }, emit);
  }

  Future<void> _onClearCache(
    _ClearCache event,
    Emitter<SettingsState> emit,
  ) async {
    await _doIfData((data, emit) async {
      await _cacheService.clear();

      // Обновляем состояние токена после очистки кэша
      final hasToken = _authStorage.getToken() != null;
      final currentToken = _authStorage.getToken();
      final tokenExpiresAt = _authStorage.getTokenExpiry();

      emit(
        CommonStates.data(
          data.copyWith(
            isCacheCleared: true,
            hasToken: hasToken,
            currentToken: currentToken,
            tokenExpiresAt: tokenExpiresAt,
          ),
        ),
      );
      emitEffect(const SettingsEffect.cacheCleared());
    }, emit);
  }

  Future<void> _onExportData(
    _ExportData event,
    Emitter<SettingsState> emit,
  ) async {
    await _doIfData((data, emit) async {
      final tracks = await _audioRepository.getListenedAudio();

      if (tracks.isEmpty) {
        emitEffect(const SettingsEffect.noDataToExport());
        return;
      }

      await _exportService.shareAllData();
      emitEffect(const SettingsEffect.dataExported());
      emit(CommonStates.data(data));
    }, emit);
  }

  Future<void> _onLoadCurrentData(
    _LoadCurrentData event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const CommonStates.loading());

      final hasToken = _authStorage.getToken() != null;
      final currentToken = _authStorage.getToken();
      final tokenExpiresAt = _authStorage.getTokenExpiry();
      final clientId = _authStorage.getVkAppId();

      emit(
        CommonStates.data(
          SettingsData(
            hasToken: hasToken,
            currentToken: currentToken,
            tokenExpiresAt: tokenExpiresAt,
            clientId: clientId ?? 'Рандомный (От Vk Admin, лол)',
            isCacheCleared: false,
          ),
        ),
      );
    } catch (e, st) {
      emit(CommonStates.error(AppException.from(e, st: st)));
    }
  }
}
