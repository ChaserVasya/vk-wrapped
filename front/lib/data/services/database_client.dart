import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/services/api_client.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';

/// Клиент для работы с базой данных через Yandex Cloud Functions
@injectable
class DatabaseClient {
  final ApiClient _apiClient;

  DatabaseClient(this._apiClient);

  /// Получает все сессии пользователя с бэкенда
  Future<IList<AudioTrack>> getUserSessions() async {
    final response = await _apiClient.getUserSessions();

    return response.map((session) => _mapSessionToTrack(session)).toIList();
  }

  /// Преобразует сессию из бэкенда в AudioTrack
  AudioTrack _mapSessionToTrack(Map<String, dynamic> session) {
    final fullId = session['full_id'] as String? ?? '';

    // Парсим full_id для получения информации о треке
    // full_id обычно в формате "owner_id_audio_id"
    final parts = fullId.split('_');
    final ownerId = parts.isNotEmpty ? parts[0] : '0';
    final audioId = parts.length > 1 ? parts[1] : '0';

    final firstObserved =
        DateTime.tryParse(session['first_observed'] as String? ?? '') ??
        DateTime.now();
    final lastSeen =
        DateTime.tryParse(session['last_seen'] as String? ?? '') ??
        DateTime.now();

    // Вычисляем количество прослушиваний на основе времени
    final duration = lastSeen.difference(firstObserved).inSeconds;
    final playCount = (duration / 180).round(); // Примерно 3 минуты на трек

    return AudioTrack(
      id: audioId,
      title: 'Unknown Track', // Нужно получать с VK API
      artist: 'Unknown Artist', // Нужно получать с VK API
      url: 'https://vk.com/audio${ownerId}_$audioId',
      duration: duration,
      playCount: playCount,
      albumCover: null,
      lastPlayed: lastSeen,
    );
  }

  /// Получает детальную информацию о треке с VK API
  Future<AudioTrack> getTrackDetails(String fullId) async {
    //todo
    // Здесь нужно добавить запрос к VK API для получения деталей трека
    // Пока возвращаем базовую информацию
    final parts = fullId.split('_');
    final ownerId = parts.isNotEmpty ? parts[0] : '0';
    final audioId = parts.length > 1 ? parts[1] : '0';

    return AudioTrack(
      id: audioId,
      title: 'Track $audioId',
      artist: 'Artist',
      url: 'https://vk.com/audio${ownerId}_$audioId',
      duration: 180,
      playCount: 1,
      albumCover: null,
      lastPlayed: DateTime.now(),
    );
  }
}
