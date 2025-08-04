part of 'token_setup_bloc.dart';

@freezed
class TokenSetupState with _$TokenSetupState {
  const factory TokenSetupState.initial() = TokenSetupState$Initial;
  const factory TokenSetupState.loading() = TokenSetupState$Loading;
  const factory TokenSetupState.saving() = TokenSetupState$Saving;
  const factory TokenSetupState.dataLoaded({
    required String? currentToken,
    required String currentClientId,
  }) = TokenSetupState$DataLoaded;
} 