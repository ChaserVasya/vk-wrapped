import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'generated/database.g.dart';

class AudioTracks extends Table {
  IntColumn get id => integer()();
  IntColumn get ownerId => integer()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  IntColumn get duration => integer()();
  TextColumn get url => text()();

  @override
  Set<Column> get primaryKey => {id, ownerId};
}

@DriftDatabase(tables: [AudioTracks])
@injectable
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'audio_tracks.db'));
    return NativeDatabase.createInBackground(file);
  });
}
