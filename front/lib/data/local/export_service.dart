import 'dart:convert';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

@lazySingleton
class ExportService {
  final SharePlus _sharePlus;

  ExportService(this._sharePlus);

  /// Экспортирует треки в JSON файл и открывает его
  Future<void> shareData(IList<VkAudioTrack> tracks) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/audio_tracks.json');

    final jsonString = jsonEncode(
      const JsonEncoder.withIndent(' ').convert(tracks.unlock),
    );

    await file.writeAsString(jsonString);
    await _sharePlus.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Экспортированные данные VK Wrapped',
      ),
    );
  }
}
