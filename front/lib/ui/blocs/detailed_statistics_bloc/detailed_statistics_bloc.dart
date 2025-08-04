import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/enhanced_statistics_service.dart';
import 'package:front/features/utils/lib/src/bloc/safe_bloc.dart';

part 'detailed_statistics_bloc.freezed.dart';
part 'detailed_statistics_event.dart';
part 'detailed_statistics_state.dart';
part 'detailed_statistics_effect.dart';

@injectable
class DetailedStatisticsBloc
    extends EffectBloc<DetailedStatisticsEvent, DetailedStatisticsState> {
  DetailedStatisticsBloc() : super(const DetailedStatisticsState.initial()) {
    on<_LoadStatistics>(_onLoadStatistics);
  }

  Future<void> _onLoadStatistics(
    _LoadStatistics event,
    Emitter<DetailedStatisticsState> emit,
  ) async {
    emit(const DetailedStatisticsState.loading());

    try {
      final statistics = await EnhancedStatisticsService.getFullStatistics(
        event.tracks,
      );
      emit(DetailedStatisticsState.data(statistics: statistics));
    } catch (e) {
      emit(DetailedStatisticsState.error(message: e.toString()));
      emitEffect(DetailedStatisticsEffect.error(message: e.toString()));
    }
  }
}
