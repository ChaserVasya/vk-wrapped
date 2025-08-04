part of 'detailed_statistics_bloc.dart';

@freezed
sealed class DetailedStatisticsEvent with _$DetailedStatisticsEvent {
  const factory DetailedStatisticsEvent.init() = _Init;
}
