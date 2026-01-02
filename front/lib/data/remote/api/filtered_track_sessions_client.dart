import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/local/prefs_storage.dart';
import 'package:front/data/remote/api/track_sessions_client.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:injectable/injectable.dart';

/// Обертка над TrackSessionsClient, которая фильтрует сессии по диапазону дат
/// Фильтрация происходит на клиентской стороне и не влияет на сохраненные данные
@lazySingleton
class FilteredTrackSessionsClient {
  final TrackSessionsClient _sessionsClient;
  final PrefsStorage _prefsStorage;

  FilteredTrackSessionsClient(this._sessionsClient, this._prefsStorage);

  /// Получает сессии с применением фильтра по диапазону дат
  Future<IList<TrackSession>> getSessions() async {
    // Получаем все сессии из API
    final allSessions = await _sessionsClient.getSessions();

    // Получаем фильтр из преференсов
    final filter = _prefsStorage.getDateRangeFilter();

    // Если фильтр не установлен, возвращаем все сессии
    if (filter == null) {
      return allSessions.toIList();
    }

    // Фильтруем сессии по диапазону дат
    final filteredSessions = allSessions.where((session) {
      final firstObserved = session.firstObservedDateTime;
      final lastSeen = session.lastSeenDateTime;
      return filter.matchesSession(
        firstObserved: firstObserved,
        lastSeen: lastSeen,
      );
    }).toList();

    return filteredSessions.toIList();
  }
}
