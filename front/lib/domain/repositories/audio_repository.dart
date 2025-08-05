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

  /// Получает треки и сессии за один запрос
  Future<(IList<VkAudioTrack>, IList<TrackSession>)> getAudioData() async {
    final localTracks = await _trackStorage.getTracks();
    final sessions = await _sessionsClient.getSessions();

    final localTrackFullIds = localTracks.map((track) => track.fullId).toSet();

    final missingIds = sessions
        .map((s) => s.fullId)
        .where((fullId) => !localTrackFullIds.contains(fullId))
        .toList();

    IList<VkAudioTrack> tracks;
    if (missingIds.isNotEmpty) {
      final missingTracks = await _vkApiService.getAudioById(missingIds);
      await _trackStorage.updateTracks(missingTracks);
      tracks = localTracks.addAll(missingTracks);
    } else {
      tracks = localTracks;
    }

    return (tracks, sessions.toIList());
  }

  Future<IList<VkAudioTrack>> getListenedAudio() async {
    final (tracks, _) = await getAudioData();
    return tracks;
  }

  /// Получает треки с количеством их прослушиваний
  Future<IList<(VkAudioTrack, int)>> getTracksWithPlayCount() async {
    final (tracks, sessions) = await getAudioData();
    final trackPlayCount = <String, int>{};

    // Подсчитываем количество прослушиваний для каждого трека
    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      final trackKey = track.fullId;
      trackPlayCount[trackKey] = (trackPlayCount[trackKey] ?? 0) + 1;
    }

    // Создаем пары трек-количество прослушиваний
    final tracksWithCount = tracks
        .map((track) => (track, trackPlayCount[track.fullId] ?? 0))
        .toIList();

    return tracksWithCount;
  }

  Future<IList<TrackSession>> getSessions() async {
    final (_, sessions) = await getAudioData();
    return sessions;
  }

  /// Получает объекты артистов с информацией о фотографиях
  Future<IList<VkArtist>> getArtists() async {
    final tracks = await getListenedAudio();
    final artistNames = <String>{};
    for (final track in tracks) {
      artistNames.addAll(track.artists);
    }

    // Создаем объекты VkArtist с доступной информацией
    // В будущем можно добавить API вызов для получения фотографий
    final artists = artistNames
        .map(
          (name) => VkArtist(
            id: name.hashCode, // Используем hashCode как временный ID
            name: name,
            domain: null,
            photo: null, // Пока нет API для получения фотографий артистов
          ),
        )
        .toIList();

    return artists;
  }

  /// Получает артистов с количеством их песен
  Future<IList<(VkArtist, int)>> getArtistsWithSongCount() async {
    final tracks = await getListenedAudio();
    final artistSongCount = <String, int>{};

    // Подсчитываем количество песен для каждого артиста
    for (final track in tracks) {
      // Считаем каждого артиста отдельно
      for (final artist in track.artists) {
        artistSongCount[artist] = (artistSongCount[artist] ?? 0) + 1;
      }
    }

    // Создаем объекты VkArtist с количеством песен
    final artistsWithCount = artistSongCount.entries
        .map(
          (entry) => (
            VkArtist(
              id: entry.key.hashCode,
              name: entry.key,
              domain: null,
              photo: null,
            ),
            entry.value,
          ),
        )
        .toIList();

    return artistsWithCount;
  }

  Future<IList<VkAlbum>> getAlbums() async {
    final tracks = await getListenedAudio();
    final albums = <VkAlbum>{};
    for (final track in tracks) {
      if (track.album != null) {
        albums.add(track.album!);
      }
    }
    return albums.toIList();
  }

  /// Получает альбомы с количеством их треков
  Future<IList<(VkAlbum, int)>> getAlbumsWithTrackCount() async {
    final tracks = await getListenedAudio();
    final albumTrackCount = <String, int>{};

    // Подсчитываем количество треков для каждого альбома
    for (final track in tracks) {
      if (track.album != null) {
        final albumKey = '${track.album!.id}_${track.album!.ownerId}';
        albumTrackCount[albumKey] = (albumTrackCount[albumKey] ?? 0) + 1;
      }
    }

    // Создаем объекты VkAlbum с количеством треков
    final albumsWithCount = albumTrackCount.entries.map((entry) {
      final albumId = int.parse(entry.key.split('_')[0]);
      final ownerId = int.parse(entry.key.split('_')[1]);

      // Находим оригинальный альбом из треков
      final originalAlbum = tracks
          .where((track) => track.album != null)
          .map((track) => track.album!)
          .firstWhere(
            (album) => album.id == albumId && album.ownerId == ownerId,
          );

      return (originalAlbum, entry.value);
    }).toIList();

    return albumsWithCount;
  }
}
