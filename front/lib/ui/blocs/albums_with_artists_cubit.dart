import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class AlbumsWithArtistsCubit
    extends Cubit<CommonStates<IList<(VkAlbum, IList<String>, int)>>> {
  final AudioRepository _audioRepository;

  AlbumsWithArtistsCubit(this._audioRepository)
    : super(const CommonStates.loading());

  Future<void> init() async {
    try {
      emit(const CommonStates.loading());
      final albumsWithArtists = await _audioRepository
          .getAlbumsWithArtistsAndTrackCount();
      emit(CommonStates.data(albumsWithArtists));
    } catch (e, st) {
      emit(CommonStates.error(AppException.from(e, st: st)));
    }
  }
}
