import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/internal/di/di.dart';
import 'package:injectable/injectable.dart';

@injectable
class AlbumsCubit extends Cubit<CommonStates<IList<VkAlbum>>> {
  AlbumsCubit() : super(const CommonStates.loading());

  Future<void> init() async {
    try {
      emit(const CommonStates.loading());

      // Получаем треки и извлекаем уникальные альбомы
      final audioRepository = getIt<AudioRepository>();
      final tracks = await audioRepository.getListenedAudio();

      // Извлекаем уникальные альбомы из треков
      final albums = <VkAlbum>{};
      for (final track in tracks) {
        if (track.album != null) {
          albums.add(track.album!);
        }
      }

      emit(CommonStates.data(albums.toIList()));
    } catch (e, s) {
      emit(CommonStates.error(AppException.from(e, st: s)));
    }
  }
}
