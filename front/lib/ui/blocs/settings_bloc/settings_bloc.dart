import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/local/export_service.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/storages/auth_storage.dart';
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
  ) : super(const SettingsState.initial()) {
    on<_ClearToken>(_onClearToken);
    on<_SaveToken>(_onSaveToken);
    on<_ClearCache>(_onClearCache);
    on<_ExportData>(_onExportData);
    on<_LoadCurrentData>(_onLoadCurrentData);
  }

  Future<void> _onClearToken(
    _ClearToken event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());
      await _cacheService.clearToken();
      emit(const SettingsState.tokenConfigured(hasToken: false));
      emitEffect(const SettingsEffect.tokenCleared());
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }

  Future<void> _onSaveToken(
    _SaveToken event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());
      await _authStorage.saveToken(event.token);
      emit(const SettingsState.tokenConfigured(hasToken: true));
      emitEffect(const SettingsEffect.tokenSaved());
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }

  Future<void> _onClearCache(
    _ClearCache event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());
      await _cacheService.clear();
      emit(const SettingsState.cacheStatus(isCleared: true));
      emitEffect(const SettingsEffect.cacheCleared());
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }

  Future<void> _onExportData(
    _ExportData event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());
      final tracks = await _audioRepository.getListenedAudio();

      if (tracks.isEmpty) {
        emitEffect(const SettingsEffect.noDataToExport());
        return;
      }

      await _exportService.exportToJson(tracks);
      emitEffect(const SettingsEffect.dataExported());
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }

  Future<void> _onLoadCurrentData(
    _LoadCurrentData event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());

      final hasToken = _authStorage.getToken() != null;
      final currentToken = _authStorage.getToken();
      final clientId = _authStorage.getVkAppId();

      emit(
        SettingsState.currentData(
          hasToken: hasToken,
          currentToken: currentToken,
          clientId: clientId ?? 'Дефолтный (От Kate mobile, лол)',
        ),
      );
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }
}
