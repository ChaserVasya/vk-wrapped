import 'dart:convert';
import 'dart:io';

import 'package:front/domain/entities/audio_track.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Сервис для экспорта данных
class ExportService {
  /// Экспортирует данные в JSON файл
  static Future<void> exportToJson(List<AudioTrack> tracks) async {
    try {
      final data = {
        'exportDate': DateTime.now().toIso8601String(),
        'tracks': tracks.map((track) => track.toJson()).toList(),
        'totalTracks': tracks.length,
        'totalDuration': tracks.fold<int>(
          0,
          (sum, track) => sum + track.duration,
        ),
      };

      final jsonString = const JsonEncoder.withIndent('  ').convert(data);

      // Получаем временную директорию
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/vk_wrapped_export.json');

      // Записываем файл
      await file.writeAsString(jsonString);

      // Делимся файлом
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: 'VK Wrapped Export'),
      );
    } catch (e) {
      throw Exception('Error exporting data: $e');
    }
  }

  /// Экспортирует статистику в JSON
  static Future<void> exportStatistics(Map<String, dynamic> statistics) async {
    try {
      final data = {
        'exportDate': DateTime.now().toIso8601String(),
        'statistics': statistics,
      };

      final jsonString = const JsonEncoder.withIndent('  ').convert(data);

      // Получаем временную директорию
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/vk_wrapped_statistics.json');

      // Записываем файл
      await file.writeAsString(jsonString);

      // Делимся файлом
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: 'VK Wrapped Statistics'),
      );
    } catch (e) {
      throw Exception('Error exporting statistics: $e');
    }
  }
}
