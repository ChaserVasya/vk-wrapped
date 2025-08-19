import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/audio_storage/audio_storage.dart';
import 'package:front/data/remote/api/track_sessions_client.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/data/remote/services/vk_service.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
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

    // Фильтруем недоступные треки из missingIds
    final missingIds = <String>[];
    for (final session in sessions) {
      final fullId = session.fullId;
      if (!localTrackFullIds.contains(fullId)) {
        // Проверяем, не помечен ли трек как недоступный
        final parts = fullId.split('_');
        if (parts.length == 2) {
          final id = int.tryParse(parts[0]);
          final ownerId = int.tryParse(parts[1]);

          if (id != null && ownerId != null) {
            final isUnavailable = await _trackStorage.isTrackUnavailable(
              id,
              ownerId,
            );
            if (isUnavailable) {
              print('[INFO] Skipping unavailable track in repository: $fullId');
              continue;
            }
          }
        }
        missingIds.add(fullId);
      }
    }

    IList<VkAudioTrack> tracks;
    if (missingIds.isNotEmpty) {
      VkAudioResult? result;
      try {
        result = await _vkApiService.getAudioById(missingIds.toIList());

        // Сохраняем частично загруженные треки
        final missingTracks = result.tracks;
        await _trackStorage.updateTracks(missingTracks);

        // Если есть ошибки при загрузке, пробрасываем их после сохранения данных
        if (result.hasErrors) {
          throw AppException(
            result.errorMessage ?? 'Ошибка при загрузке треков',
            code: 'VK_LOAD_ERROR',
          );
        }

        tracks = localTracks.addAll(missingTracks);
      } catch (e) {
        // Проверяем, является ли ошибка сигналом о том, что аудио недоступно
        if (result != null) {
          // Помечаем только те треки, которые действительно недоступны
          for (final error in result.errors) {
            if (error is VkAudioUnavailableException) {
              final audioId = error.message
                  .split(': ')
                  .last; // Извлекаем ID из сообщения
              final parts = audioId.split('_');
              if (parts.length == 2) {
                final id = int.tryParse(parts[0]);
                final ownerId = int.tryParse(parts[1]);

                if (id != null && ownerId != null) {
                  await _trackStorage.markTrackAsUnavailable(
                    id,
                    ownerId,
                    audioId,
                  );
                }
              }
            }
          }
        }

        // Если в result.errors есть только VkAudioUnavailableException, не пробрасываем ошибку
        // Если есть другие ошибки (AppException), пробрасываем их
        if (result != null) {
          final hasNonUnavailableErrors = result.errors.any(
            (error) => error is! VkAudioUnavailableException,
          );
          if (hasNonUnavailableErrors) {
            rethrow;
          }
        } else {
          // Если result == null, значит ошибка произошла до получения результата
          // (например, NoTokenException), пробрасываем её
          rethrow;
        }

        tracks = localTracks;
      }

      // Проверяем целостность данных после загрузки
      final allTrackIds = tracks.map((track) => track.fullId).toSet();
      final sessionIds = sessions.map((s) => s.fullId).toSet();
      final missingSessionTracks = sessionIds.difference(allTrackIds);

      if (missingSessionTracks.isNotEmpty) {
        // Логируем проблему для отладки
        print(
          '[WARNING] Found ${missingSessionTracks.length} sessions without corresponding tracks: ${missingSessionTracks.take(5).join(', ')}',
        );

        // Дополнительная отладочная информация
        print('[DEBUG] Total tracks loaded: ${tracks.length}');
        print('[DEBUG] Total sessions: ${sessions.length}');
        print(
          '[DEBUG] Sample track IDs: ${tracks.take(3).map((t) => t.fullId).join(', ')}',
        );
        print(
          '[DEBUG] Sample session IDs: ${sessions.take(3).map((s) => s.fullId).join(', ')}',
        );
      }
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
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков
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

  /// Получает информацию об артисте по его ID из VK API
  Future<VkArtistInfo> getArtistInfoById(String artistId) async {
    return await _vkApiService.getArtistById(artistId);
  }

  /// Получает артистов с заполненными фотографиями из VK API с кешированием
  Future<IList<VkArtist>> getArtistsWithPhotos() async {
    final tracks = await getListenedAudio();
    final artistIds = <String>{};

    // Собираем уникальные ID артистов из mainArtists
    for (final track in tracks) {
      if (track.mainArtists != null) {
        for (final artist in track.mainArtists!) {
          artistIds.add(artist.id);
        }
      }
    }

    final artistsWithPhotos = <VkArtist>[];

    for (final artistId in artistIds) {
      try {
        // Сначала проверяем кеш
        final cachedArtist = await _trackStorage.getCachedArtist(artistId);
        if (cachedArtist != null) {
          artistsWithPhotos.add(cachedArtist);
          continue;
        }

        // Если артист не в кеше и не проверялся, загружаем из API
        if (!await _trackStorage.isArtistPhotoChecked(artistId)) {
          final artistInfo = await getArtistInfoById(artistId);

          // Извлекаем URL лучшего фото
          String? photoUrl;
          if (artistInfo.photos != null && artistInfo.photos!.isNotEmpty) {
            final cropPhoto = artistInfo.photos!.firstWhere(
              (photo) => photo.type == 'crop',
              orElse: () => artistInfo.photos!.first,
            );

            if (cropPhoto.photo.isNotEmpty) {
              // Выбираем лучшее качество фото
              final bestPhoto = cropPhoto.photo.reduce(
                (a, b) => a.width > b.width ? a : b,
              );
              photoUrl = bestPhoto.url;
            }
          }

          // Создаем VkArtist с фотографией
          final artist = VkArtist(
            id: artistInfo.id.hashCode,
            name: artistInfo.name,
            domain: artistInfo.domain,
            photo: photoUrl,
          );

          // Сохраняем в кеш
          await _trackStorage.saveCachedArtist(artist);
          artistsWithPhotos.add(artist);
        } else {
          // Артист уже проверялся, но нет в кеше - значит у него нет фото
          // Создаем артиста без фото из mainArtists
          final mainArtist = tracks
              .expand((track) => track.mainArtists ?? [])
              .firstWhere((artist) => artist.id == artistId);

          final artist = VkArtist(
            id: mainArtist.id.hashCode,
            name: mainArtist.name,
            domain: mainArtist.domain,
            photo: null,
          );

          artistsWithPhotos.add(artist);
        }
      } catch (e, _) {
        // Помечаем артиста как проверенного, но без фото
        await _trackStorage.markArtistPhotoChecked(artistId, false);
        print('[WARNING] Failed to load artist info for $artistId: $e');

        // Создаем артиста без фото из mainArtists
        try {
          final mainArtist = tracks
              .expand((track) => track.mainArtists ?? [])
              .firstWhere((artist) => artist.id == artistId);

          final artist = VkArtist(
            id: mainArtist.id.hashCode,
            name: mainArtist.name,
            domain: mainArtist.domain,
            photo: null,
          );

          artistsWithPhotos.add(artist);
        } catch (_) {
          // Если не можем найти артиста в mainArtists, пропускаем
        }
      }
    }

    return artistsWithPhotos.toIList();
  }

  /// Обновляет фотографии артистов, которые еще не были проверены
  /// Используется при первом запуске после обновления приложения
  Future<void> updateArtistPhotosInBackground() async {
    try {
      final artistsToUpdate = await _trackStorage.getArtistsToUpdate();

      if (artistsToUpdate.isEmpty) {
        print('[INFO] All artists photos are up to date');
        return;
      }

      print(
        '[INFO] Updating photos for ${artistsToUpdate.length} artists in background',
      );

      // Обрабатываем по 5 артистов за раз, чтобы не перегружать API
      const batchSize = 5;
      for (int i = 0; i < artistsToUpdate.length; i += batchSize) {
        final batch = artistsToUpdate.skip(i).take(batchSize);

        await Future.wait(
          batch.map((artistId) async {
            try {
              // Проверяем, не обработали ли уже этого артиста
              if (await _trackStorage.isArtistPhotoChecked(artistId)) {
                return;
              }

              final artistInfo = await getArtistInfoById(artistId);

              // Извлекаем URL лучшего фото
              String? photoUrl;
              if (artistInfo.photos != null && artistInfo.photos!.isNotEmpty) {
                final cropPhoto = artistInfo.photos!.firstWhere(
                  (photo) => photo.type == 'crop',
                  orElse: () => artistInfo.photos!.first,
                );

                if (cropPhoto.photo.isNotEmpty) {
                  final bestPhoto = cropPhoto.photo.reduce(
                    (a, b) => a.width > b.width ? a : b,
                  );
                  photoUrl = bestPhoto.url;
                }
              }

              // Создаем и сохраняем артиста
              final artist = VkArtist(
                id: artistInfo.id.hashCode,
                name: artistInfo.name,
                domain: artistInfo.domain,
                photo: photoUrl,
              );

              await _trackStorage.saveCachedArtist(artist);
              print('[DEBUG] Updated photo for artist: ${artist.name}');
            } catch (e, _) {
              // Помечаем как проверенного, но без фото
              await _trackStorage.markArtistPhotoChecked(artistId, false);
              print(
                '[WARNING] Failed to update artist photo for $artistId: $e',
              );
            }
          }),
        );

        // Небольшая пауза между батчами, чтобы не перегружать API
        if (i + batchSize < artistsToUpdate.length) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }

      print('[INFO] Finished updating artist photos in background');
    } catch (e, _) {
      print('[ERROR] Failed to update artist photos in background: $e');
    }
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

  /// Получает альбомы с авторами и количеством треков
  Future<IList<(VkAlbum, IList<String>, int)>>
  getAlbumsWithArtistsAndTrackCount() async {
    final tracks = await getListenedAudio();
    final albumData =
        <String, ({VkAlbum album, Set<String> artists, int trackCount})>{};

    // Подсчитываем данные для каждого альбома
    for (final track in tracks) {
      if (track.album != null) {
        final albumKey = '${track.album!.id}_${track.album!.ownerId}';

        if (albumData.containsKey(albumKey)) {
          final current = albumData[albumKey]!;
          albumData[albumKey] = (
            album: current.album,
            artists: current.artists..addAll(track.artists),
            trackCount: current.trackCount + 1,
          );
        } else {
          albumData[albumKey] = (
            album: track.album!,
            artists: track.artists.toSet(),
            trackCount: 1,
          );
        }
      }
    }

    // Создаем результат с сортировкой по количеству треков
    final albumsWithArtists =
        albumData.values
            .map(
              (data) => (data.album, data.artists.toIList(), data.trackCount),
            )
            .toList()
          ..sort((a, b) => b.$3.compareTo(a.$3));

    return albumsWithArtists.toIList();
  }

  /// Получает статистику по жанрам
  Future<IList<({String genre, int songCount, int totalDuration})>>
  getGenreStats() async {
    final tracks = await getListenedAudio();
    final genreStats = <String, ({int songCount, int totalDuration})>{};

    // Подсчитываем статистику для каждого жанра
    for (final track in tracks) {
      if (track.genreName != null) {
        final genre = track.genreName!;

        if (genreStats.containsKey(genre)) {
          final current = genreStats[genre]!;
          genreStats[genre] = (
            songCount: current.songCount + 1,
            totalDuration: current.totalDuration + track.duration,
          );
        } else {
          genreStats[genre] = (songCount: 1, totalDuration: track.duration);
        }
      }
    }

    // Сортируем по количеству песен
    final sortedGenreStats =
        genreStats.entries
            .map(
              (entry) => (
                genre: entry.key,
                songCount: entry.value.songCount,
                totalDuration: entry.value.totalDuration,
              ),
            )
            .toList()
          ..sort((a, b) => b.songCount.compareTo(a.songCount));

    return sortedGenreStats.toIList();
  }

  /// Получает количество уникальных альбомов
  Future<int> getUniqueAlbumsCount() async {
    final tracks = await getListenedAudio();
    final uniqueAlbums = <String>{};

    for (final track in tracks) {
      if (track.album != null) {
        uniqueAlbums.add('${track.album!.id}_${track.album!.ownerId}');
      }
    }

    return uniqueAlbums.length;
  }

  /// Получает количество уникальных жанров
  Future<int> getUniqueGenresCount() async {
    final tracks = await getListenedAudio();
    final uniqueGenres = <String>{};

    for (final track in tracks) {
      if (track.genreName != null) {
        uniqueGenres.add(track.genreName!);
      }
    }

    return uniqueGenres.length;
  }

  /// Получает топ треков с одинаковым названием
  Future<
    IList<
      ({String title, int trackCount, int totalPlayCount, int totalDuration})
    >
  >
  getTracksWithSameTitle() async {
    final tracks = await getListenedAudio();
    final titleStats =
        <String, ({int trackCount, int totalPlayCount, int totalDuration})>{};

    // Подсчитываем статистику для каждого названия
    for (final track in tracks) {
      final title = track.title.trim();

      if (titleStats.containsKey(title)) {
        final current = titleStats[title]!;
        titleStats[title] = (
          trackCount: current.trackCount + 1,
          totalPlayCount:
              current.totalPlayCount +
              1, // Каждый трек считается как одно прослушивание
          totalDuration: current.totalDuration + track.duration,
        );
      } else {
        titleStats[title] = (
          trackCount: 1,
          totalPlayCount: 1,
          totalDuration: track.duration,
        );
      }
    }

    // Фильтруем только те названия, у которых больше одного трека
    final tracksWithSameTitle =
        titleStats.entries
            .where((entry) => entry.value.trackCount > 1)
            .map(
              (entry) => (
                title: entry.key,
                trackCount: entry.value.trackCount,
                totalPlayCount: entry.value.totalPlayCount,
                totalDuration: entry.value.totalDuration,
              ),
            )
            .toList()
          ..sort((a, b) => b.trackCount.compareTo(a.trackCount));

    return tracksWithSameTitle.toIList();
  }
}
