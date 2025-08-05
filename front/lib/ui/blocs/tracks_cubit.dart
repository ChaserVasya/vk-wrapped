import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class TracksCubit extends Cubit<CommonStates<IList<(VkAudioTrack, int)>>> {
  TracksCubit(this._audioRepository) : super(const CommonStates.loading());

  final AudioRepository _audioRepository;

  Future<void> init() async {
    try {
      emit(const CommonStates.loading());
      final tracksWithCount = await _audioRepository.getTracksWithPlayCount();
      emit(CommonStates.data(tracksWithCount));
    } catch (e, st) {
      emit(CommonStates.error(AppException.from(e, st: st)));
    }
  }
}
