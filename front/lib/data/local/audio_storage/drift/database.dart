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
}

class AlbumThumbs extends Table {
  IntColumn get albumId => integer()();
  IntColumn get albumOwnerId => integer()();
  TextColumn get thumbId => text()();
}

@DriftDatabase(
  tables: [AudioTracks, Albums, Thumbs, MainArtists, TrackAlbums, AlbumThumbs],
)
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
