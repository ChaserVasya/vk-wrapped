part of 'token_setup_bloc.dart';

@freezed
abstract class TokenSetupState with _$TokenSetupState {
  const factory TokenSetupState({
    required String vkAppId,
    required String? currentToken,
    required String? tokenGenerationUrl,
  }) = TokenSetupState$DataLoaded;
}
