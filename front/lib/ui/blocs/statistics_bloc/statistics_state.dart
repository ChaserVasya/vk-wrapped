import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/services/statistics_service.dart';

part 'statistics_state.freezed.dart';

@freezed
abstract class StatisticStateData with _$StatisticStateData {
  const factory StatisticStateData({
    required IList<ArtistStats> topArtists,
    required IList<TrackWithStats> topTracks,
    required IList<
      ({String title, int trackCount, int totalPlayCount, int totalDuration})
    >
    tracksWithSameTitle,
    required Duration totalListeningTime,
    required int uniqueTracksCount,
    required int uniqueArtistsCount,
    required int uniqueAlbumsCount,
    required int uniqueGenresCount,
    required Duration averageTrackDuration,
    required IList<TimeOfDayStats> timeOfDayStats,
    required IList<DayOfWeekStats> dayOfWeekStats,
    required IList<MonthStats> monthStats,
    required MostActiveDayStats? mostActiveDay,
    required VkAudioTrack? longestTrack,
    required VkAudioTrack? shortestTrack,
    required int totalPlayCount,
  }) = _StatisticStateData;
}
