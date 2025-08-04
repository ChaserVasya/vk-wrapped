part of 'token_setup_bloc.dart';

@freezed
sealed class TokenSetupEvent with _$TokenSetupEvent {
  const factory TokenSetupEvent.vkTokenResponseProvided(String url) =
      _VkTokenResponseProvided;
  const factory TokenSetupEvent.vkAppIdSaved(String vkAppId) = _VkAppIdSaved;
}
