part of 'token_setup_bloc.dart';

@freezed
sealed class TokenSetupEvent with _$TokenSetupEvent {
  const factory TokenSetupEvent.loadCurrentData() = _LoadCurrentData;
  const factory TokenSetupEvent.saveToken({
    required String token,
    required String clientId,
  }) = _SaveToken;
  const factory TokenSetupEvent.openTokenUrl() = _OpenTokenUrl;
} 