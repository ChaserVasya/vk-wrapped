import 'package:front/data/services/vk_api_service.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@injectable
class AudioRepository {
  final VkApiService _vkApiService;

  AudioRepository(this._vkApiService);

  Future<IList<AudioTrack>> getAudioById(IList<String> audioIds) async {
    return await _vkApiService.getAudioById(audioIds);
  }

  Future<AudioTrack?> getSingleAudioById(String audioId) async {
    return await _vkApiService.getSingleAudioById(audioId);
  }

  Future<IList<AudioTrack>> getUserAudio({int? count, int? offset}) async {
    return await _vkApiService.getUserAudio(count: count, offset: offset);
  }

  Future<IList<AudioTrack>> getPopularAudio({int? count, int? offset}) async {
    return await _vkApiService.getPopularAudio(count: count, offset: offset);
  }
}
