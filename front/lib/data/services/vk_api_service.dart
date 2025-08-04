import 'package:dio/dio.dart';
import 'package:front/data/services/database_client.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/data/services/vk_api_client.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';

@injectable
class VkApiService {
  VkApiClient? _client;
  final DatabaseClient _databaseClient;
  final TokenService _tokenService;

  VkApiService(this._databaseClient, this._tokenService);

  void setToken(String token) {
    final dio = Dio();
    _client = VkApiClient(dio, baseUrl: 'https://api.vk.com/method');
  }

  Future<List<AudioTrack>> getAudioById(List<String> audioIds) async {
    if (_client == null) {
      throw Exception('VK API client not initialized. Set token first.');
    }

    if (audioIds.isEmpty) {
      return [];
    }

    final audiosParam = audioIds.join(',');
    final response = await _client!.getAudioById(
      audios: audiosParam,
      accessToken: await _getAccessToken(),
    );

    return response.response
        .map((vkTrack) => _convertVkTrackToAudioTrack(vkTrack))
        .toList();
  }

  Future<AudioTrack?> getSingleAudioById(String audioId) async {
    final tracks = await getAudioById([audioId]);
    return tracks.isNotEmpty ? tracks.first : null;
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
            final trackDetails = await getSingleAudioById(session.id);
            if (trackDetails != null) {
              detailedTracks.add(trackDetails);
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
      accessToken: await _getAccessToken(),
    );

    return response.response
        .map((vkTrack) => _convertVkTrackToAudioTrack(vkTrack))
        .toList();
  }

  Future<String> _getAccessToken() async {
    final token = await _tokenService.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('VK API token not found. Please set token first.');
    }
    return token;
  }

  AudioTrack _convertVkTrackToAudioTrack(VkAudioTrack vkTrack) {
    return AudioTrack(
      id: '${vkTrack.ownerId}_${vkTrack.id}',
      title: vkTrack.title,
      artist: vkTrack.artist,
      duration: vkTrack.duration,
      url: vkTrack.url,
      lastPlayed: DateTime.fromMillisecondsSinceEpoch(vkTrack.date * 1000),
    );
  }
}
