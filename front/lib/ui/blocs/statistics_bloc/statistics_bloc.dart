import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
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
  final AudioRepository _audioRepository;

  StatisticsBloc(this._statisticsService, this._audioRepository)
    : super(const CommonStates.loading()) {
    on<StatisticsEvent$LoadStatistics>(_onLoadStatistics);
  }

  Future<void> _onLoadStatistics(
    StatisticsEvent$LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(const StatisticsState.loading());

    try {
      final (tracks, sessions) = await _audioRepository.getAudioData();
      final statistic = _statisticsService.createStatistics(tracks, sessions);

      emit(CommonStates.data(statistic));
    } catch (e, st) {
      emit(CommonStates.error(AppException.from(e, st: st)));
    }
  }
}
