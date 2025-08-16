import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsService {
  StatisticsService();

  /// Создает полную статистику на основе списка треков и сессий
  StatisticStateData createStatistics(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    final topArtists = _getTopArtists(tracks, sessions);
    final topTracks = _getTopTracks(tracks, sessions);
    final totalListeningTime = _getTotalListeningTime(tracks, sessions);
    final uniqueTracksCount = _getUniqueTracksCount(sessions);
    final uniqueArtistsCount = _getUniqueArtistsCount(tracks, sessions);
    final uniqueAlbumsCount = _getUniqueAlbumsCount(tracks);
    final uniqueGenresCount = _getUniqueGenresCount(tracks);
    final tracksWithSameTitle = _getTracksWithSameTitle(tracks);
    final averageTrackDuration = _getAverageTrackDuration(tracks, sessions);
    final timeOfDayStats = _getTimeOfDayStats(sessions);
    final dayOfWeekStats = _getDayOfWeekStats(sessions);
    final monthStats = _getMonthStats(sessions);
    final mostActiveDay = _getMostActiveDay(tracks, sessions);
    final longestTrack = _getLongestTrack(tracks, sessions);
    final shortestTrack = _getShortestTrack(tracks, sessions);
    final totalPlayCount = _getTotalPlayCount(sessions);

    return StatisticStateData(
      topArtists: topArtists,
      topTracks: topTracks,
      tracksWithSameTitle: tracksWithSameTitle,
      totalListeningTime: totalListeningTime,
      uniqueTracksCount: uniqueTracksCount,
      uniqueArtistsCount: uniqueArtistsCount,
      uniqueAlbumsCount: uniqueAlbumsCount,
      uniqueGenresCount: uniqueGenresCount,
      averageTrackDuration: averageTrackDuration,
      timeOfDayStats: timeOfDayStats,
      dayOfWeekStats: dayOfWeekStats,
      monthStats: monthStats,
      mostActiveDay: mostActiveDay,
      longestTrack: longestTrack,
      shortestTrack: shortestTrack,
      totalPlayCount: totalPlayCount,
    );
  }

  // 🎵 МУЗЫКАЛЬНАЯ СТАТИСТИКА

  /// Топ исполнителей по количеству прослушиваний
  IList<ArtistStats> _getTopArtists(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    final artistStats = <String, ArtistStats>{};

    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков

      // Считаем каждого артиста отдельно
      for (final artist in track.artists) {
        if (artistStats.containsKey(artist)) {
          artistStats[artist] = artistStats[artist]!.copyWith(
            playCount: artistStats[artist]!.playCount + 1,
            totalDuration: artistStats[artist]!.totalDuration + track.duration,
          );
        } else {
          artistStats[artist] = ArtistStats(
            name: artist,
            playCount: 1,
            totalDuration: track.duration,
          );
        }
      }
    }

    final sortedArtists = artistStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedArtists.take(5).toIList();
  }

  /// Топ треков по количеству прослушиваний
  IList<TrackWithStats> _getTopTracks(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    final trackStats = <String, TrackWithStats>{};

    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков

      // Используем полный ID трека как ключ для уникальности
      final trackKey = track.fullId;

      if (trackStats.containsKey(trackKey)) {
        trackStats[trackKey] = trackStats[trackKey]!.copyWith(
          playCount: trackStats[trackKey]!.playCount + 1,
        );
      } else {
        trackStats[trackKey] = TrackWithStats(track: track, playCount: 1);
      }
    }

    final sortedTracks = trackStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedTracks.take(10).toIList();
  }

  /// Общее время прослушивания
  Duration _getTotalListeningTime(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    int totalSeconds = 0;
    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков
      totalSeconds += track.duration;
    }

    return Duration(seconds: totalSeconds);
  }

  /// Количество уникальных треков
  int _getUniqueTracksCount(IList<TrackSession> sessions) {
    final uniqueTrackIds = sessions.map((s) => s.fullId).toSet();
    return uniqueTrackIds.length;
  }

  /// Количество уникальных исполнителей
  int _getUniqueArtistsCount(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    final uniqueArtists = <String>{};
    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков
      uniqueArtists.addAll(track.artists);
    }

    return uniqueArtists.length;
  }

  /// Средняя продолжительность трека
  Duration _getAverageTrackDuration(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    if (sessions.isEmpty) return Duration.zero;

    int totalDuration = 0;
    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков
      totalDuration += track.duration;
    }

    return Duration(seconds: totalDuration ~/ sessions.length);
  }

  /// Статистика по времени суток
  IList<TimeOfDayStats> _getTimeOfDayStats(IList<TrackSession> sessions) {
    final timeStats = <int, TimeOfDayStats>{};

    for (final session in sessions) {
      final hour = session.firstObservedDateTime.hour;
      if (timeStats.containsKey(hour)) {
        timeStats[hour] = timeStats[hour]!.copyWith(
          playCount: timeStats[hour]!.playCount + 1,
        );
      } else {
        timeStats[hour] = TimeOfDayStats(hour: hour, playCount: 1);
      }
    }

    final sortedStats = timeStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedStats.toIList();
  }

  /// Статистика по дням недели
  IList<DayOfWeekStats> _getDayOfWeekStats(IList<TrackSession> sessions) {
    final dayStats = <int, DayOfWeekStats>{};

    for (final session in sessions) {
      final weekday = session.firstObservedDateTime.weekday;
      if (dayStats.containsKey(weekday)) {
        dayStats[weekday] = dayStats[weekday]!.copyWith(
          playCount: dayStats[weekday]!.playCount + 1,
        );
      } else {
        dayStats[weekday] = DayOfWeekStats(weekday: weekday, playCount: 1);
      }
    }

    final sortedStats = dayStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedStats.toIList();
  }

  /// Статистика по месяцам
  IList<MonthStats> _getMonthStats(IList<TrackSession> sessions) {
    final monthStats = <int, MonthStats>{};

    for (final session in sessions) {
      final month = session.firstObservedDateTime.month;
      if (monthStats.containsKey(month)) {
        monthStats[month] = monthStats[month]!.copyWith(
          playCount: monthStats[month]!.playCount + 1,
        );
      } else {
        monthStats[month] = MonthStats(month: month, playCount: 1);
      }
    }

    final sortedStats = monthStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedStats.toIList();
  }

  /// Самый активный день
  MostActiveDayStats? _getMostActiveDay(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    if (sessions.isEmpty) return null;

    final dayStats = <DateTime, ({int playCount, int totalDuration})>{};

    for (final session in sessions) {
      // Проверяем что timestamp корректный (не 0 и не слишком старый)
      if (session.firstObserved <= 0) continue;

      final day = session.firstObservedDateTime;
      // Дополнительная проверка что дата не слишком старая (до 2020 года)
      if (day.year < 2020) continue;

      final dayStart = session.firstObservedDay;
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков

      if (dayStats.containsKey(dayStart)) {
        final current = dayStats[dayStart]!;
        dayStats[dayStart] = (
          playCount: current.playCount + 1,
          totalDuration: current.totalDuration + track.duration,
        );
      } else {
        dayStats[dayStart] = (playCount: 1, totalDuration: track.duration);
      }
    }

    // Если нет корректных дат, возвращаем null
    if (dayStats.isEmpty) return null;

    final mostActiveDayEntry = dayStats.entries.reduce(
      (a, b) => a.value.playCount > b.value.playCount ? a : b,
    );

    return MostActiveDayStats(
      date: mostActiveDayEntry.key,
      playCount: mostActiveDayEntry.value.playCount,
      totalDuration: mostActiveDayEntry.value.totalDuration,
    );
  }

  /// Самый длинный трек
  VkAudioTrack? _getLongestTrack(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    if (sessions.isEmpty) return null;

    VkAudioTrack? longestTrack;
    int maxDuration = 0;

    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков
      if (track.duration > maxDuration) {
        maxDuration = track.duration;
        longestTrack = track;
      }
    }

    return longestTrack;
  }

  /// Самый короткий трек
  VkAudioTrack? _getShortestTrack(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    if (sessions.isEmpty) return null;

    VkAudioTrack? shortestTrack;
    int minDuration = 9223372036854775807; // int.maxFinite equivalent

    for (final session in sessions) {
      final track = tracks.where((t) => t.fullId == session.fullId).firstOrNull;
      if (track == null)
        continue; // Пропускаем сессии без соответствующих треков
      if (track.duration < minDuration) {
        minDuration = track.duration;
        shortestTrack = track;
      }
    }

    return shortestTrack;
  }

  /// Общее количество прослушиваний
  int _getTotalPlayCount(IList<TrackSession> sessions) {
    return sessions.length;
  }

  /// Количество уникальных альбомов
  int _getUniqueAlbumsCount(IList<VkAudioTrack> tracks) {
    final uniqueAlbums = <String>{};
    for (final track in tracks) {
      if (track.album != null) {
        uniqueAlbums.add('${track.album!.id}_${track.album!.ownerId}');
      }
    }
    return uniqueAlbums.length;
  }

  /// Количество уникальных жанров
  int _getUniqueGenresCount(IList<VkAudioTrack> tracks) {
    final uniqueGenres = <String>{};
    for (final track in tracks) {
      if (track.genreName != null) {
        uniqueGenres.add(track.genreName!);
      }
    }
    return uniqueGenres.length;
  }

  /// Топ треков с одинаковым названием
  IList<({String title, int trackCount, int totalPlayCount, int totalDuration})>
  _getTracksWithSameTitle(IList<VkAudioTrack> tracks) {
    final titleStats =
        <String, ({int trackCount, int totalPlayCount, int totalDuration})>{};

    // Подсчитываем статистику для каждого названия
    for (final track in tracks) {
      final title = track.title.trim();

      if (titleStats.containsKey(title)) {
        final current = titleStats[title]!;
        titleStats[title] = (
          trackCount: current.trackCount + 1,
          totalPlayCount: current.totalPlayCount + 1,
          totalDuration: current.totalDuration + track.duration,
        );
      } else {
        titleStats[title] = (
          trackCount: 1,
          totalPlayCount: 1,
          totalDuration: track.duration,
        );
      }
    }

    // Фильтруем только те названия, у которых больше одного трека
    final tracksWithSameTitle =
        titleStats.entries
            .where((entry) => entry.value.trackCount > 1)
            .map(
              (entry) => (
                title: entry.key,
                trackCount: entry.value.trackCount,
                totalPlayCount: entry.value.totalPlayCount,
                totalDuration: entry.value.totalDuration,
              ),
            )
            .toList()
          ..sort((a, b) => b.trackCount.compareTo(a.trackCount));

    return tracksWithSameTitle.take(10).toIList();
  }
}

// 📊 МОДЕЛИ ДАННЫХ ДЛЯ СТАТИСТИКИ

class MostActiveDayStats {
  final DateTime date;
  final int playCount;
  final int totalDuration;

  const MostActiveDayStats({
    required this.date,
    required this.playCount,
    required this.totalDuration,
  });

  MostActiveDayStats copyWith({
    DateTime? date,
    int? playCount,
    int? totalDuration,
  }) {
    return MostActiveDayStats(
      date: date ?? this.date,
      playCount: playCount ?? this.playCount,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}

class TrackWithStats {
  final VkAudioTrack track;
  final int playCount;

  const TrackWithStats({required this.track, required this.playCount});

  TrackWithStats copyWith({VkAudioTrack? track, int? playCount}) {
    return TrackWithStats(
      track: track ?? this.track,
      playCount: playCount ?? this.playCount,
    );
  }
}

class ArtistStats {
  final String name;
  final int playCount;
  final int totalDuration;

  const ArtistStats({
    required this.name,
    required this.playCount,
    required this.totalDuration,
  });

  ArtistStats copyWith({String? name, int? playCount, int? totalDuration}) {
    return ArtistStats(
      name: name ?? this.name,
      playCount: playCount ?? this.playCount,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}

class TrackStats {
  final String title;
  final String artist;
  final int duration;
  final int playCount;
  final int totalDuration;

  const TrackStats({
    required this.title,
    required this.artist,
    required this.duration,
    required this.playCount,
    required this.totalDuration,
  });

  TrackStats copyWith({
    String? title,
    String? artist,
    int? duration,
    int? playCount,
    int? totalDuration,
  }) {
    return TrackStats(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      playCount: playCount ?? this.playCount,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}

class TimeOfDayStats {
  final int hour;
  final int playCount;

  const TimeOfDayStats({required this.hour, required this.playCount});

  TimeOfDayStats copyWith({int? hour, int? playCount}) {
    return TimeOfDayStats(
      hour: hour ?? this.hour,
      playCount: playCount ?? this.playCount,
    );
  }

  String get hourLabel {
    if (hour == 0) return 'Полночь';
    if (hour < 12) return '$hour:00';
    if (hour == 12) return 'Полдень';
    return '$hour:00';
  }
}

class DayOfWeekStats {
  final int weekday;
  final int playCount;

  const DayOfWeekStats({required this.weekday, required this.playCount});

  DayOfWeekStats copyWith({int? weekday, int? playCount}) {
    return DayOfWeekStats(
      weekday: weekday ?? this.weekday,
      playCount: playCount ?? this.playCount,
    );
  }

  String get dayLabel {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[weekday - 1];
  }
}

class MonthStats {
  final int month;
  final int playCount;

  const MonthStats({required this.month, required this.playCount});

  MonthStats copyWith({int? month, int? playCount}) {
    return MonthStats(
      month: month ?? this.month,
      playCount: playCount ?? this.playCount,
    );
  }

  String get monthLabel {
    const months = [
      'Янв',
      'Фев',
      'Мар',
      'Апр',
      'Май',
      'Июн',
      'Июл',
      'Авг',
      'Сен',
      'Окт',
      'Ноя',
      'Дек',
    ];
    return months[month - 1];
  }
}
