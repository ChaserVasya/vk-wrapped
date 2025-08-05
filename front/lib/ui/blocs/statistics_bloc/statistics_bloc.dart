import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/services/statistics_service.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_event.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_state.dart';
import 'package:injectable/injectable.dart';

typedef StatisticsState = CommonStates<StatisticStateData>;

@injectable
class StatisticsBloc extends EffectBloc<StatisticsEvent, StatisticsState> {
  final StatisticsService _statisticsService;

  StatisticsBloc(this._statisticsService)
    : super(const CommonStates.loading()) {
    on<StatisticsEvent$LoadStatistics>(_onLoadStatistics);
  }

  Future<void> _onLoadStatistics(
    StatisticsEvent$LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(const StatisticsState.loading());

    try {
      final topArtists = await _statisticsService.getTopArtists();
      final topTracks = await _statisticsService.getTopTracks();
      final totalListeningTime = await _statisticsService
          .getTotalListeningTime();
      final uniqueTracksCount = await _statisticsService.getUniqueTracksCount();
      final uniqueArtistsCount = await _statisticsService
          .getUniqueArtistsCount();
      final averageTrackDuration = await _statisticsService
          .getAverageTrackDuration();
      final timeOfDayStats = await _statisticsService.getTimeOfDayStats();
      final dayOfWeekStats = await _statisticsService.getDayOfWeekStats();
      final monthStats = await _statisticsService.getMonthStats();
      final mostActiveDay = await _statisticsService.getMostActiveDay();
      final longestTrack = await _statisticsService.getLongestTrack();
      final shortestTrack = await _statisticsService.getShortestTrack();
      final totalPlayCount = await _statisticsService.getTotalPlayCount();

      emit(
        CommonStates.data(
          StatisticStateData(
            topArtists: topArtists,
            topTracks: topTracks,
            totalListeningTime: totalListeningTime,
            uniqueTracksCount: uniqueTracksCount,
            uniqueArtistsCount: uniqueArtistsCount,
            averageTrackDuration: averageTrackDuration,
            timeOfDayStats: timeOfDayStats,
            dayOfWeekStats: dayOfWeekStats,
            monthStats: monthStats,
            mostActiveDay: mostActiveDay,
            longestTrack: longestTrack,
            shortestTrack: shortestTrack,
            totalPlayCount: totalPlayCount,
          ),
        ),
      );
    } catch (e, st) {
      emit(CommonStates.error(AppException(e.toString(), st: st)));
    }
  }
}
