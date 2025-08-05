import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_event.freezed.dart';

@freezed
abstract class StatisticsEvent with _$StatisticsEvent {
  const factory StatisticsEvent.loadStatistics() =
      StatisticsEvent$LoadStatistics;
}
