part of 'home_bloc.dart';

@freezed
sealed class HomeEffect with _$HomeEffect {
  const factory HomeEffect.tokenSaved() = HomeEffect$TokenSaved;
  const factory HomeEffect.tokenError({required String message}) =
      HomeEffect$TokenError;
  const factory HomeEffect.showTokenDialog() = HomeEffect$ShowTokenDialog;
}
