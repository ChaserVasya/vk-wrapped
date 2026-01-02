part of 'settings_bloc.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.clearToken() = _ClearToken;
  const factory SettingsEvent.saveToken(String token) = _SaveToken;
  const factory SettingsEvent.clearCache() = _ClearCache;
  const factory SettingsEvent.exportData() = _ExportData;
  const factory SettingsEvent.loadCurrentData() = _LoadCurrentData;
  const factory SettingsEvent.saveDateRangeFilter(DateRangeFilter? filter) =
      _SaveDateRangeFilter;
}
