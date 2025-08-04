import 'dart:convert';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class ExportService {
  /// Экспортирует треки в JSON файл
  Future<File> exportToJson(IList<AudioTrack> tracks) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/audio_tracks.json');

    final tracksJson = tracks.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(tracksJson);

    await file.writeAsString(jsonString);
    return file;
  }
}
