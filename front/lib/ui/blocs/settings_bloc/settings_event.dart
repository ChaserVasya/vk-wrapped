part of 'settings_bloc.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.checkTokenStatus() = _CheckTokenStatus;
  const factory SettingsEvent.clearToken() = _ClearToken;
  const factory SettingsEvent.saveToken(String token) = _SaveToken;
  const factory SettingsEvent.clearCache() = _ClearCache;
  const factory SettingsEvent.exportData() = _ExportData;
}
