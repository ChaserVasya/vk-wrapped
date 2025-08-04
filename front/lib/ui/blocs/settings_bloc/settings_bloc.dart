import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/data/local/export_service.dart';
import 'package:front/data/local/vk_token_storage.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:injectable/injectable.dart';

part 'settings_bloc.freezed.dart';
part 'settings_effect.dart';
part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends EffectBloc<SettingsEvent, SettingsState> {
  final PrefsStorage _cacheService;
  final VkTokenStorage _tokenService;
  final ExportService _exportService;

  SettingsBloc({
    required PrefsStorage cacheService,
    required VkTokenStorage tokenService,
    required ExportService exportService,
  }) : _cacheService = cacheService,
       _tokenService = tokenService,
       _exportService = exportService,
       super(const SettingsState.initial()) {
    on<_CheckTokenStatus>(_onCheckTokenStatus);
    on<_ClearToken>(_onClearToken);
    on<_SaveToken>(_onSaveToken);
    on<_ClearCache>(_onClearCache);
    on<_ExportData>(_onExportData);
    on<_LoadCurrentData>(_onLoadCurrentData);
  }

  Future<void> _onCheckTokenStatus(
    _CheckTokenStatus event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());
      final hasToken = await _tokenService.hasToken();
      emit(SettingsState.tokenConfigured(hasToken: hasToken));
      emitEffect(SettingsEffect.showTokenDialog(hasToken: hasToken));
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }

  Future<void> _onClearToken(
    _ClearToken event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsState.loading());
      await _tokenService.clearToken();
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
      await _tokenService.saveToken(event.token);
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
      await _cacheService.clearCache();
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
      final tracks = await _cacheService.getCachedTracks();

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

      final hasToken = await _tokenService.hasToken();
      final currentToken = await _tokenService.getToken();
      final clientId = await _tokenService.getClientId();

      emit(
        SettingsState.currentData(
          hasToken: hasToken,
          currentToken: currentToken,
          clientId: clientId,
        ),
      );
    } catch (e) {
      emitEffect(SettingsEffect.error(message: e.toString()));
    }
  }
}
