import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/audio_storage/audio_storage.dart';
import 'package:front/data/local/audio_storage/drift/database.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AudioStorage)
class DriftAudioStorage implements AudioStorage {
  final AppDatabase _database;

  const DriftAudioStorage(this._database);

  @override
  Future<IList<VkAudioTrack>> getTracks() async {
    final tracks = await _database.select(_database.audioTracks).get();

    return tracks
        .map(
          (track) => VkAudioTrack(
            id: track.id,
            ownerId: track.ownerId,
            title: track.title,
            artist: track.artist,
            duration: track.duration,
            url: track.url,
          ),
        )
        .toIList();
  }

  @override
  Future<void> updateTracks(IList<VkAudioTrack> tracks) async {
    await _database.transaction(() async {
      await _database.delete(_database.audioTracks).go();

      if (tracks.isNotEmpty) {
        await _database.batch((batch) {
          batch.insertAll(
            _database.audioTracks,
            tracks.map(
              (track) => AudioTracksCompanion.insert(
                id: track.id,
                ownerId: track.ownerId,
                title: track.title,
                artist: track.artist,
                duration: track.duration,
                url: track.url,
              ),
            ),
          );
        });
      }
    });
  }

  @override
  Future<void> deleteAllTracks() async {
    await _database.delete(_database.audioTracks).go();
  }
}
