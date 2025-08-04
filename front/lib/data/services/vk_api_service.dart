import 'package:front/domain/entities/audio_track.dart';
import 'package:front/data/services/vk_api_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class VkApiService {
  VkApiClient? _client;

  void setToken(String token) {
    _client = VkApiClient(token);
  }

  Future<List<AudioTrack>> getAudioById(List<String> audioIds) async {
    if (_client == null) {
      throw Exception('VK API client not initialized. Set token first.');
    }

    final response = await _client!.getAudioById(audioIds);
    return response.map((json) => AudioTrack.fromJson(json)).toList();
  }

  Future<AudioTrack?> getSingleAudioById(String audioId) async {
    if (_client == null) {
      throw Exception('VK API client not initialized. Set token first.');
    }

    final response = await _client!.getSingleAudioById(audioId);
    return response != null ? AudioTrack.fromJson(response) : null;
  }

  /// Получает аудио пользователя
  Future<List<AudioTrack>> getUserAudio({int? count, int? offset}) async {
    if (_client == null) {
      throw Exception('VK API client not initialized. Set token first.');
    }

    final response = await _client!.getUserAudio(count: count, offset: offset);
    return response.map((json) => AudioTrack.fromJson(json)).toList();
  }

  /// Получает популярные аудио
  Future<List<AudioTrack>> getPopularAudio({int? count, int? offset}) async {
    if (_client == null) {
      throw Exception('VK API client not initialized. Set token first.');
    }

    final response = await _client!.getPopularAudio(
      count: count,
      offset: offset,
    );
    return response.map((json) => AudioTrack.fromJson(json)).toList();
  }
}
