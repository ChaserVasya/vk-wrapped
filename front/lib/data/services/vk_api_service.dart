import 'package:front/domain/entities/audio_track.dart';
import 'package:front/data/services/vk_api_client.dart';
import 'package:front/data/services/database_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class VkApiService {
  VkApiClient? _client;
  final DatabaseClient _databaseClient;

  VkApiService(this._databaseClient);

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

  /// Получает аудио пользователя из базы данных
  Future<List<AudioTrack>> getUserAudio({int? count, int? offset}) async {
    try {
      // Получаем сессии из базы данных
      final sessions = await _databaseClient.getUserSessions();

      // Если есть VK API клиент, получаем детали треков
      if (_client != null) {
        final detailedTracks = <AudioTrack>[];
        for (final session in sessions) {
          try {
            final trackDetails = await _client!.getSingleAudioById(session.id);
            if (trackDetails != null) {
              detailedTracks.add(AudioTrack.fromJson(trackDetails));
            } else {
              detailedTracks.add(session);
            }
          } catch (e) {
            // Если не удалось получить детали, используем базовую информацию
            detailedTracks.add(session);
          }
        }
        return detailedTracks;
      }

      // Если нет VK API клиента, возвращаем базовую информацию из сессий
      return sessions;
    } catch (e) {
      throw Exception('Failed to get user audio: $e');
    }
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
