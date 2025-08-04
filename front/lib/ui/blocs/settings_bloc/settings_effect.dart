part of 'settings_bloc.dart';

@freezed
sealed class SettingsEffect with _$SettingsEffect {
  const factory SettingsEffect.tokenCleared() = SettingsEffect$TokenCleared;
  const factory SettingsEffect.tokenSaved() = SettingsEffect$TokenSaved;
  const factory SettingsEffect.cacheCleared() = SettingsEffect$CacheCleared;
  const factory SettingsEffect.dataExported() = SettingsEffect$DataExported;
  const factory SettingsEffect.noDataToExport() = SettingsEffect$NoDataToExport;
  const factory SettingsEffect.error({required String message}) =
      SettingsEffect$Error;
}
