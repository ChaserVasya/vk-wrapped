part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = SettingsState$Initial;
  const factory SettingsState.loading() = SettingsState$Loading;
  const factory SettingsState.tokenConfigured({required bool hasToken}) =
      SettingsState$TokenConfigured;
  const factory SettingsState.cacheStatus({required bool isCleared}) =
      SettingsState$CacheStatus;
}
