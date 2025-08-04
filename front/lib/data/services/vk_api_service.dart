import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/services/database_client.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/data/services/vk_api_client.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VkApiService {
  final VkApiClient _client;
  final DatabaseClient _databaseClient;
  final TokenService _tokenService;

  VkApiService(this._databaseClient, this._tokenService, this._client);

  Future<IList<AudioTrack>> getAudioById(IList<String> audioIds) async {
    if (audioIds.isEmpty) {
      return const IListConst([]);
    }

    final token = await _tokenService.getToken();
    final audiosParam = audioIds.join(',');
    final response = await _client.getAudioById(
      audios: audiosParam,
      accessToken: token!,
    );

    return response.response
        .map((vkTrack) => _convertVkTrackToAudioTrack(vkTrack))
        .toIList();
  }

  Future<AudioTrack?> getSingleAudioById(String audioId) async {
    final tracks = await getAudioById([audioId].toIList());
    return tracks.isNotEmpty ? tracks.first : null;
  }

  /// Получает аудио пользователя из базы данных
  Future<IList<AudioTrack>> getUserAudio({int? count, int? offset}) async {
    // Получаем сессии из базы данных
    final sessions = await _databaseClient.getUserSessions();

    // Если есть VK API клиент, получаем детали треков
    final detailedTracks = <AudioTrack>[];
    for (final session in sessions) {
      final trackDetails = await getSingleAudioById(session.id);
      if (trackDetails != null) {
        detailedTracks.add(trackDetails);
      } else {
        detailedTracks.add(session);
      }
    }
    return detailedTracks.toIList();
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
