part of 'token_setup_bloc.dart';

@freezed
sealed class TokenSetupEffect with _$TokenSetupEffect {
  const factory TokenSetupEffect.finish() = TokenSetupEffect$Finish;
}
