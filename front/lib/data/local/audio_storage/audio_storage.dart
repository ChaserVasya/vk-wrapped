import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/remote/api/vk_api_client.dart';

abstract interface class AudioStorage {
  Future<IList<VkAudioTrack>> getTracks();

  Future<void> updateTracks(IList<VkAudioTrack> tracks);

  Future<void> deleteAllTracks();
}
