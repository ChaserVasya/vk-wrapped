import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'generated/database.g.dart';

class AudioTracks extends Table {
  IntColumn get id => integer()();
  IntColumn get ownerId => integer()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  IntColumn get duration => integer()();
  TextColumn get url => text()();
  IntColumn get date => integer().nullable()();
  IntColumn get genreId => integer().nullable()();
  IntColumn get lyricsId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id, ownerId};
}

class Albums extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  IntColumn get ownerId => integer()();
  TextColumn get mainColor => text().nullable()();

  @override
  Set<Column> get primaryKey => {id, ownerId};
}

class Thumbs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get width => integer()();
  IntColumn get height => integer()();
  TextColumn get thumbId => text()();
  TextColumn get photo34 => text().nullable()();
  TextColumn get photo135 => text().nullable()();
  TextColumn get photo300 => text().nullable()();
  TextColumn get photo600 => text().nullable()();
}

class MainArtists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get domain => text().nullable()();
  TextColumn get artistId => text()();
  IntColumn get trackId => integer()();
  IntColumn get trackOwnerId => integer()();
}

class TrackAlbums extends Table {
  IntColumn get trackId => integer()();
  IntColumn get trackOwnerId => integer()();
  IntColumn get albumId => integer()();
  IntColumn get albumOwnerId => integer()();

  @override
  Set<Column> get primaryKey => {trackId, trackOwnerId, albumId, albumOwnerId};
}

class AlbumThumbs extends Table {
  IntColumn get albumId => integer()();
  IntColumn get albumOwnerId => integer()();
  TextColumn get thumbId => text()();

  @override
  Set<Column> get primaryKey => {albumId, albumOwnerId, thumbId};
}

class UnavailableTracks extends Table {
  IntColumn get id => integer()();
  IntColumn get ownerId => integer()();
  TextColumn get fullId => text()();

  @override
  Set<Column> get primaryKey => {id, ownerId};
}

class CachedArtists extends Table {
  TextColumn get artistId => text()();
  TextColumn get name => text()();
  TextColumn get domain => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  DateTimeColumn get lastUpdated => dateTime()();
  BoolColumn get photoChecked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {artistId};
}

@DriftDatabase(
  tables: [
    AudioTracks,
    Albums,
    Thumbs,
    MainArtists,
    TrackAlbums,
    AlbumThumbs,
    UnavailableTracks,
    CachedArtists,
  ],
)
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Создаем таблицу UnavailableTracks при обновлении с версии 1 до 2
        await m.createTable(unavailableTracks);
      }
      if (from < 3) {
        // Создаем таблицу CachedArtists при обновлении с версии 2 до 3
        await m.createTable(cachedArtists);
      }
      if (from < 4) {
        // Очищаем таблицу CachedArtists из-за исправления бага с ID
        // Старые записи содержали hashCode вместо оригинального artistId
        await m.deleteTable('cached_artists');
        await m.createTable(cachedArtists);
      }
    },
  );
}
