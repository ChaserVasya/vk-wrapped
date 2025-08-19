import 'package:drift/drift.dart';
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

    final result = <VkAudioTrack>[];

    for (final track in tracks) {
      // Получаем альбом для трека
      VkAlbum? album;
      final trackAlbum =
          await (_database.select(_database.trackAlbums)..where(
                (t) =>
                    t.trackId.equals(track.id) &
                    t.trackOwnerId.equals(track.ownerId),
              ))
              .getSingleOrNull();

      if (trackAlbum != null) {
        final albumData =
            await (_database.select(_database.albums)..where(
                  (a) =>
                      a.id.equals(trackAlbum.albumId) &
                      a.ownerId.equals(trackAlbum.albumOwnerId),
                ))
                .getSingleOrNull();

        if (albumData != null) {
          // Получаем thumb для альбома
          VkThumb? thumb;
          final albumThumbs =
              await (_database.select(_database.albumThumbs)..where(
                    (at) =>
                        at.albumId.equals(albumData.id) &
                        at.albumOwnerId.equals(albumData.ownerId),
                  ))
                  .get();

          final albumThumb = albumThumbs.isNotEmpty ? albumThumbs.first : null;

          if (albumThumb != null) {
            final thumbsData = await (_database.select(
              _database.thumbs,
            )..where((t) => t.thumbId.equals(albumThumb.thumbId))).get();

            final thumbData = thumbsData.isNotEmpty ? thumbsData.first : null;

            if (thumbData != null) {
              thumb = VkThumb(
                width: thumbData.width,
                height: thumbData.height,
                id: thumbData.thumbId,
                photo34: thumbData.photo34,
                photo135: thumbData.photo135,
                photo300: thumbData.photo300,
                photo600: thumbData.photo600,
              );
            }
          }

          album = VkAlbum(
            id: albumData.id,
            title: albumData.title,
            ownerId: albumData.ownerId,
            mainColor: albumData.mainColor,
            thumb: thumb,
          );
        }
      }

      // Получаем main artists для трека
      final mainArtistsData =
          await (_database.select(_database.mainArtists)..where(
                (ma) =>
                    ma.trackId.equals(track.id) &
                    ma.trackOwnerId.equals(track.ownerId),
              ))
              .get();

      final mainArtists = mainArtistsData
          .map(
            (artist) => VkMainArtist(
              name: artist.name,
              domain: artist.domain,
              id: artist.artistId,
            ),
          )
          .toList();

      result.add(
        VkAudioTrack(
          id: track.id,
          ownerId: track.ownerId,
          title: track.title,
          artist: track.artist,
          duration: track.duration,
          url: track.url,
          date: track.date,
          genreId: track.genreId,
          lyricsId: track.lyricsId,
          album: album,
          mainArtists: mainArtists.isNotEmpty ? mainArtists : null,
        ),
      );
    }

    return result.toIList();
  }

  @override
  Future<void> updateTracks(IList<VkAudioTrack> tracks) async {
    await _database.transaction(() async {
      if (tracks.isNotEmpty) {
        await _database.batch((batch) {
          // Добавляем все треки (новые и обновленные)
          for (final track in tracks) {
            batch.insert(
              _database.audioTracks,
              AudioTracksCompanion.insert(
                id: track.id,
                ownerId: track.ownerId,
                title: track.title,
                artist: track.artist,
                duration: track.duration,
                url: track.url,
                date: Value(track.date),
                genreId: Value(track.genreId),
                lyricsId: Value(track.lyricsId),
              ),
              mode: InsertMode.insertOrReplace,
            );

            // Обрабатываем альбомы и thumbs
            if (track.album != null) {
              // Вставляем или обновляем альбом
              batch.insert(
                _database.albums,
                AlbumsCompanion.insert(
                  id: track.album!.id,
                  title: track.album!.title,
                  ownerId: track.album!.ownerId,
                  mainColor: Value(track.album!.mainColor),
                ),
                mode: InsertMode.insertOrReplace,
              );

              // Обрабатываем thumb альбома
              if (track.album!.thumb != null) {
                batch.insert(
                  _database.thumbs,
                  ThumbsCompanion.insert(
                    width: track.album!.thumb!.width,
                    height: track.album!.thumb!.height,
                    thumbId: track.album!.thumb!.id,
                    photo34: Value(track.album!.thumb!.photo34),
                    photo135: Value(track.album!.thumb!.photo135),
                    photo300: Value(track.album!.thumb!.photo300),
                    photo600: Value(track.album!.thumb!.photo600),
                  ),
                  mode: InsertMode.insertOrReplace,
                );

                batch.insert(
                  _database.albumThumbs,
                  AlbumThumbsCompanion.insert(
                    albumId: track.album!.id,
                    albumOwnerId: track.album!.ownerId,
                    thumbId: track.album!.thumb!.id,
                  ),
                  mode: InsertMode.insertOrReplace,
                );
              }

              // Связываем трек с альбомом
              batch.insert(
                _database.trackAlbums,
                TrackAlbumsCompanion.insert(
                  trackId: track.id,
                  trackOwnerId: track.ownerId,
                  albumId: track.album!.id,
                  albumOwnerId: track.album!.ownerId,
                ),
                mode: InsertMode.insertOrReplace,
              );
            }

            // Обрабатываем main artists
            if (track.mainArtists != null) {
              for (final artist in track.mainArtists!) {
                batch.insert(
                  _database.mainArtists,
                  MainArtistsCompanion.insert(
                    name: artist.name,
                    domain: Value(artist.domain),
                    artistId: artist.id,
                    trackId: track.id,
                    trackOwnerId: track.ownerId,
                  ),
                  mode: InsertMode.insertOrReplace,
                );
              }
            }
          }
        });
      }
    });
  }

  @override
  Future<void> deleteAllTracks() async {
    await _database.transaction(() async {
      await _database.delete(_database.audioTracks).go();
      await _database.delete(_database.albums).go();
      await _database.delete(_database.thumbs).go();
      await _database.delete(_database.mainArtists).go();
      await _database.delete(_database.trackAlbums).go();
      await _database.delete(_database.albumThumbs).go();
    });
  }

  @override
  /// Проверяет, является ли трек недоступным
  Future<bool> isTrackUnavailable(int id, int ownerId) async {
    final unavailable =
        await (_database.select(_database.unavailableTracks)
              ..where((t) => t.id.equals(id) & t.ownerId.equals(ownerId)))
            .getSingleOrNull();
    return unavailable != null;
  }

  @override
  /// Добавляет трек в список недоступных
  Future<void> markTrackAsUnavailable(
    int id,
    int ownerId,
    String fullId,
  ) async {
    final existing =
        await (_database.select(_database.unavailableTracks)
              ..where((t) => t.id.equals(id) & t.ownerId.equals(ownerId)))
            .getSingleOrNull();

    if (existing == null) {
      // Создаем новую запись только если её еще нет
      await _database
          .into(_database.unavailableTracks)
          .insert(
            UnavailableTracksCompanion.insert(
              id: id,
              ownerId: ownerId,
              fullId: fullId,
            ),
          );
    }
  }

  @override
  /// Получает количество недоступных треков
  Future<int> getUnavailableTracksCount() async {
    final result = _database.selectOnly(_database.unavailableTracks)
      ..addColumns([_database.unavailableTracks.id.count()]);

    final count = await result.getSingle();
    return count.read(_database.unavailableTracks.id.count()) ?? 0;
  }

  @override
  /// Получает список недоступных треков
  Future<IList<UnavailableTrack>> getUnavailableTracks() async {
    final tracks = await _database.select(_database.unavailableTracks).get();
    return tracks.toIList();
  }

  @override
  /// Очищает список недоступных треков
  Future<void> clearUnavailableTracks() async {
    await _database.delete(_database.unavailableTracks).go();
  }

  @override
  /// Получает кешированного артиста по ID
  Future<VkArtist?> getCachedArtist(String artistId) async {
    final artist = await (_database.select(
      _database.cachedArtists,
    )..where((a) => a.artistId.equals(artistId))).getSingleOrNull();

    if (artist == null) return null;

    return VkArtist(
      id: artist.artistId.hashCode,
      name: artist.name,
      domain: artist.domain,
      photo: artist.photoUrl,
    );
  }

  @override
  /// Сохраняет артиста в кеш
  Future<void> saveCachedArtist(VkArtist artist) async {
    await _database
        .into(_database.cachedArtists)
        .insert(
          CachedArtistsCompanion.insert(
            artistId: artist.id.toString(),
            name: artist.name,
            domain: Value(artist.domain),
            photoUrl: Value(artist.photo),
            lastUpdated: DateTime.now(),
            photoChecked: const Value(true),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  /// Получает всех кешированных артистов
  Future<IList<VkArtist>> getAllCachedArtists() async {
    final artists = await _database.select(_database.cachedArtists).get();

    return artists
        .map(
          (artist) => VkArtist(
            id: artist.artistId.hashCode,
            name: artist.name,
            domain: artist.domain,
            photo: artist.photoUrl,
          ),
        )
        .toIList();
  }

  @override
  /// Проверяет, была ли уже проверена фотография артиста
  Future<bool> isArtistPhotoChecked(String artistId) async {
    final artist = await (_database.select(
      _database.cachedArtists,
    )..where((a) => a.artistId.equals(artistId))).getSingleOrNull();

    return artist?.photoChecked ?? false;
  }

  @override
  /// Помечает что фотография артиста была проверена
  Future<void> markArtistPhotoChecked(String artistId, bool hasPhoto) async {
    final existing = await (_database.select(
      _database.cachedArtists,
    )..where((a) => a.artistId.equals(artistId))).getSingleOrNull();

    if (existing != null) {
      await (_database.update(
        _database.cachedArtists,
      )..where((a) => a.artistId.equals(artistId))).write(
        CachedArtistsCompanion(
          photoChecked: const Value(true),
          lastUpdated: Value(DateTime.now()),
        ),
      );
    } else {
      // Создаем новую запись если артиста еще нет в кеше
      await _database
          .into(_database.cachedArtists)
          .insert(
            CachedArtistsCompanion.insert(
              artistId: artistId,
              name: '', // Имя будет обновлено позже
              photoChecked: const Value(true),
              lastUpdated: DateTime.now(),
            ),
          );
    }
  }

  @override
  /// Получает артистов, которые нужно обновить (без фото и не проверенных)
  Future<IList<String>> getArtistsToUpdate() async {
    // Получаем всех уникальных артистов из mainArtists
    final query = _database.selectOnly(_database.mainArtists, distinct: true);
    query.addColumns([_database.mainArtists.artistId]);
    final allArtistIds = await query.get();

    final artistIds = allArtistIds
        .map((row) => row.read(_database.mainArtists.artistId)!)
        .toList();

    // Фильтруем тех, кто еще не проверен или не имеет фото
    final uncheckedArtists = <String>[];
    for (final artistId in artistIds) {
      final cached = await getCachedArtist(artistId);
      if (cached == null || !await isArtistPhotoChecked(artistId)) {
        uncheckedArtists.add(artistId);
      }
    }

    return uncheckedArtists.toIList();
  }
}
