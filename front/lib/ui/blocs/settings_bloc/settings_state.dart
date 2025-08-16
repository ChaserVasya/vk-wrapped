part of 'settings_bloc.dart';

@freezed
abstract class SettingsData with _$SettingsData {
  const factory SettingsData({
    required bool hasToken,
    required String? currentToken,
    DateTime? tokenExpiresAt,
    required String clientId,
    required bool isCacheCleared,
  }) = _SettingsData;
}

typedef SettingsState = CommonStates<SettingsData>;
