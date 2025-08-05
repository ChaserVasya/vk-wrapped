import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenresCubit
    extends
        Cubit<
          CommonStates<
            IList<({String genre, int songCount, int totalDuration})>
          >
        > {
  final AudioRepository _audioRepository;

  GenresCubit(this._audioRepository) : super(const CommonStates.loading());

  Future<void> init() async {
    try {
      emit(const CommonStates.loading());
      final genreStats = await _audioRepository.getGenreStats();
      emit(CommonStates.data(genreStats));
    } catch (e, st) {
      emit(CommonStates.error(AppException.from(e, st: st)));
    }
  }
}
