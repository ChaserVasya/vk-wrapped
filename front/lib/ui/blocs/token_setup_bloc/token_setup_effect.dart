part of 'token_setup_bloc.dart';

@freezed
sealed class TokenSetupEffect with _$TokenSetupEffect {
  const factory TokenSetupEffect.tokenSaved() = TokenSetupEffect$TokenSaved;
  const factory TokenSetupEffect.validationError({required String message}) =
      TokenSetupEffect$ValidationError;
  const factory TokenSetupEffect.error({required String message}) =
      TokenSetupEffect$Error;
  const factory TokenSetupEffect.openUrl({required String url}) =
      TokenSetupEffect$OpenUrl;
} 