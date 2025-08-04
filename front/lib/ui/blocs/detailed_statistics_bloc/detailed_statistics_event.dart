part of 'detailed_statistics_bloc.dart';

@freezed
sealed class DetailedStatisticsEvent with _$DetailedStatisticsEvent {
  const factory DetailedStatisticsEvent.loadStatistics(
    IList<AudioTrack> tracks,
  ) = _LoadStatistics;
  const factory DetailedStatisticsEvent.loadFromCache() = _LoadFromCache;
}
