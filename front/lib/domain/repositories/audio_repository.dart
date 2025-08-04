import 'package:front/data/services/vk_api_service.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';

@injectable
class AudioRepository {
  final VkApiService _vkApiService;

  AudioRepository(this._vkApiService);

  Future<List<AudioTrack>> getAudioById(List<String> audioIds) async {
    return await _vkApiService.getAudioById(audioIds);
  }

  Future<AudioTrack?> getSingleAudioById(String audioId) async {
    return await _vkApiService.getSingleAudioById(audioId);
  }

  Future<List<AudioTrack>> getUserAudio({int? count, int? offset}) async {
    return await _vkApiService.getUserAudio(count: count, offset: offset);
  }

  Future<List<AudioTrack>> getPopularAudio({int? count, int? offset}) async {
    return await _vkApiService.getPopularAudio(count: count, offset: offset);
  }

  Future<void> setToken(String token) async {
    _vkApiService.setToken(token);
  }
}
