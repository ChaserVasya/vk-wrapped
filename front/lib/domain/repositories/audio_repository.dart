import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/audio_storage/audio_storage.dart';
import 'package:front/data/remote/api/track_sessions_client.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/data/remote/services/vk_service.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:injectable/injectable.dart';

@injectable
class AudioRepository {
  final VkService _vkApiService;
  final AudioStorage _trackStorage;
  final TrackSessionsClient _sessionsClient;

  AudioRepository(this._vkApiService, this._trackStorage, this._sessionsClient);

  Future<IList<VkAudioTrack>> getListenedAudio() async {
    final localTracks = await _trackStorage.getTracks();
    final sessions = await _sessionsClient.getSessions();

    final localTrackFullIds = localTracks.map((track) => track.fullId).toSet();

    final missingIds = sessions
        .map((s) => s.fullId)
        .where((fullId) => !localTrackFullIds.contains(fullId))
        .toList();

    if (missingIds.isNotEmpty) {
      final missingTracks = await _vkApiService.getAudioById(missingIds);
      await _trackStorage.updateTracks(missingTracks);

      return localTracks.addAll(missingTracks);
    }

    return localTracks;
  }

  Future<IList<TrackSession>> getSessions() async {
    final sessions = await _sessionsClient.getSessions();
    return sessions.toIList();
  }
}
