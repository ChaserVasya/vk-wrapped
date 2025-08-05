import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/domain/services/statistics_service.dart';

part 'statistics_state.freezed.dart';

@freezed
abstract class StatisticStateData with _$StatisticStateData {
  const factory StatisticStateData({
    required IList<ArtistStats> topArtists,
    required IList<TrackStats> topTracks,
    required Duration totalListeningTime,
    required int uniqueTracksCount,
    required int uniqueArtistsCount,
    required Duration averageTrackDuration,
    required IList<TimeOfDayStats> timeOfDayStats,
    required IList<DayOfWeekStats> dayOfWeekStats,
    required IList<MonthStats> monthStats,
    required DateTime? mostActiveDay,
    required TrackStats? longestTrack,
    required TrackStats? shortestTrack,
    required int totalPlayCount,
  }) = _StatisticStateData;
}
