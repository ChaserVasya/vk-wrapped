import 'dart:convert';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class ExportService {
  /// Экспортирует треки в JSON файл
  Future<void> exportToJson(IList<AudioTrack> tracks) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/audio_tracks.json');

    final tracksJson = tracks.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(tracksJson);

    await file.writeAsString(jsonString);
  }

  /// Экспортирует статистику в JSON файл
  Future<void> exportStatistics(IMap<String, dynamic> statistics) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/statistics.json');

    final jsonString = jsonEncode(statistics);

    await file.writeAsString(jsonString);
  }

  /// Экспортирует данные в CSV формат
  Future<void> exportToCsv(IList<AudioTrack> tracks) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/audio_tracks.csv');

    const csvHeader = 'Title,Artist,Duration,PlayCount,LastPlayed\n';
    final csvRows = tracks
        .map((track) {
          final lastPlayed = track.lastPlayed?.toIso8601String() ?? '';
          return '${track.title},${track.artist},${track.duration},${track.playCount},$lastPlayed';
        })
        .join('\n');

    await file.writeAsString(csvHeader + csvRows);
  }
}
