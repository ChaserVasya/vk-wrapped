part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.saveToken(String token) = _SaveToken;
  const factory HomeEvent.showTokenDialog() = _ShowTokenDialog;
}
