import 'package:front/data/services/vk_api_service.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';

abstract class AudioRepository {
  Future<List<AudioTrack>> getAudioById(List<String> audioIds);
  Future<AudioTrack?> getSingleAudioById(String audioId);
  Future<List<AudioTrack>> getUserAudio({int? count, int? offset});
  Future<List<AudioTrack>> getPopularAudio({int? count, int? offset});
  Future<void> setToken(String token);
}

@injectable
class AudioRepositoryImpl implements AudioRepository {
  final VkApiService _vkApiService;

  AudioRepositoryImpl(this._vkApiService);

  @override
  Future<List<AudioTrack>> getAudioById(List<String> audioIds) async {
    return await _vkApiService.getAudioById(audioIds);
  }

  @override
  Future<AudioTrack?> getSingleAudioById(String audioId) async {
    return await _vkApiService.getSingleAudioById(audioId);
  }

  @override
  Future<List<AudioTrack>> getUserAudio({int? count, int? offset}) async {
    return await _vkApiService.getUserAudio(count: count, offset: offset);
  }

  @override
  Future<List<AudioTrack>> getPopularAudio({int? count, int? offset}) async {
    return await _vkApiService.getPopularAudio(count: count, offset: offset);
  }

  @override
  Future<void> setToken(String token) async {
    _vkApiService.setToken(token);
  }
}
