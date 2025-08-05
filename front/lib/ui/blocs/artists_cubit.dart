import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ArtistsCubit extends Cubit<CommonStates<IList<String>>> {
  ArtistsCubit(this._audioRepository) : super(const CommonStates.loading());

  final AudioRepository _audioRepository;

  Future<void> init() async {
    try {
      emit(const CommonStates.loading());
      final artists = await _audioRepository.getArtists();
      emit(CommonStates.data(artists));
    } catch (e, s) {
      emit(CommonStates.error(AppException.from(e, st: s)));
    }
  }
}
