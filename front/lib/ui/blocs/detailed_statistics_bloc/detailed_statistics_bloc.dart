import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/data/services/cache_service.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/statistics_service.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:injectable/injectable.dart';

part 'detailed_statistics_bloc.freezed.dart';
part 'detailed_statistics_effect.dart';
part 'detailed_statistics_event.dart';
part 'detailed_statistics_state.dart';

@injectable
class DetailedStatisticsBloc
    extends EffectBloc<DetailedStatisticsEvent, DetailedStatisticsState> {
  DetailedStatisticsBloc(this._cacheService, this._statisticsService)
    : super(const DetailedStatisticsState.initial()) {
    on<_LoadStatistics>(_onLoadStatistics);
    on<_LoadFromCache>(_onLoadFromCache);
  }

  final CacheService _cacheService;
  final StatisticsService _statisticsService;

  Future<void> _onLoadStatistics(
    _LoadStatistics event,
    Emitter<DetailedStatisticsState> emit,
  ) async {
    emit(const DetailedStatisticsState.loading());
    try {
      final statistics = await _statisticsService.getFullStatistics(
        event.tracks,
      );
      emit(DetailedStatisticsState.data(statistics: statistics));
    } catch (e) {
      emit(DetailedStatisticsState.error(message: e.toString()));
      emitEffect(DetailedStatisticsEffect.error(message: e.toString()));
    }
  }

  Future<void> _onLoadFromCache(
    _LoadFromCache event,
    Emitter<DetailedStatisticsState> emit,
  ) async {
    emit(const DetailedStatisticsState.loading());

    try {
      final cachedTracks = await _cacheService.getCachedTracks();
      if (cachedTracks.isEmpty) {
        emit(const DetailedStatisticsState.error(message: 'Нет данных в кэше'));
        return;
      }

      final statistics = await _statisticsService.getFullStatistics(
        cachedTracks,
      );
      emit(DetailedStatisticsState.data(statistics: statistics));
    } catch (e) {
      emit(DetailedStatisticsState.error(message: e.toString()));
      emitEffect(DetailedStatisticsEffect.error(message: e.toString()));
    }
  }
}
