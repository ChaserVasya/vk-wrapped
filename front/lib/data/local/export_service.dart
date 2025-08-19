import 'dart:convert';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/storages/auth_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

@lazySingleton
class ExportService {
  final SharePlus _sharePlus;
  final AudioRepository _audioRepository;
  final AuthStorage _authStorage;

  ExportService(this._sharePlus, this._audioRepository, this._authStorage);

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

  /// Экспортирует все данные из локальной базы данных
  Future<void> shareAllData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/vk_wrapped_complete_data.json');

    // Собираем все данные
    final allData = await _collectAllData();

    final jsonString = jsonEncode(
      const JsonEncoder.withIndent(' ').convert(allData),
    );

    await file.writeAsString(jsonString);
    await _sharePlus.share(
      ShareParams(files: [XFile(file.path)], text: 'Полные данные VK Wrapped'),
    );
  }

  /// Собирает все данные из локальной базы данных
  Future<Map<String, dynamic>> _collectAllData() async {
    // Получаем треки и сессии
    final (tracks, sessions) = await _audioRepository.getAudioData();

    // Получаем настройки
    final token = _authStorage.getToken();
    final tokenExpiry = _authStorage.getTokenExpiry();
    final clientId = _authStorage.getVkAppId();

    return {
      'exportInfo': {
        'exportDate': DateTime.now().toIso8601String(),
        'version': '1.0',
        'description': 'Сырые данные VK Wrapped из локальной базы данных',
      },
      'userSettings': {
        'hasToken': token != null,
        'tokenExpiry': tokenExpiry?.toIso8601String(),
        'clientId': clientId,
      },
      'tracks': {
        'totalCount': tracks.length,
        'data': tracks.map((track) => track.toJson()).toList(),
      },
      'sessions': {
        'totalCount': sessions.length,
        'data': sessions.map((session) => session.toJson()).toList(),
      },
    };
  }
}
