import 'package:front/domain/entities/meme_response.dart';
import 'package:front/domain/repositories/meme_repository.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MemeCubit extends EffectCubit<CommonStates<MemeResponse>> {
  final MemeRepository _memeRepository;

  MemeCubit(this._memeRepository) : super(const CommonStates.loading());

  Future<void> loadMeme() async {
    try {
      emit(const CommonStates.loading());
      final meme = await _memeRepository.getMeme();
      emit(CommonStates.data(meme));
    } catch (e, st) {
      emitErrorEffect(e, st: st);
    }
  }

  Future<void> toggleLike() async {
    try {
      final currentState = state;
      if (currentState is! CommonStateData<MemeResponse>) {
        return;
      }

      await _memeRepository.toggleMemeLike(
        memeId: currentState.ensureData.memeId,
      );

      // Обновляем состояние с противоположным статусом лайка
      final updatedMeme = currentState.ensureData.copyWith(
        isLiked: !currentState.ensureData.isLiked,
      );

      emit(CommonStates.data(updatedMeme));
    } catch (e, st) {
      emitErrorEffect(e, st: st);
    }
  }
}

extension MemeResponseCopyWith on MemeResponse {
  MemeResponse copyWith({String? memeId, String? url, bool? isLiked}) {
    return MemeResponse(
      memeId: memeId ?? this.memeId,
      url: url ?? this.url,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
