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
    final averageTrackDuration = _getAverageTrackDuration(tracks, sessions);
    final timeOfDayStats = _getTimeOfDayStats(sessions);
    final dayOfWeekStats = _getDayOfWeekStats(sessions);
    final monthStats = _getMonthStats(sessions);
    final mostActiveDay = _getMostActiveDay(sessions);
    final longestTrack = _getLongestTrack(tracks, sessions);
    final shortestTrack = _getShortestTrack(tracks, sessions);
    final totalPlayCount = _getTotalPlayCount(sessions);

    return StatisticStateData(
      topArtists: topArtists,
      topTracks: topTracks,
      totalListeningTime: totalListeningTime,
      uniqueTracksCount: uniqueTracksCount,
      uniqueArtistsCount: uniqueArtistsCount,
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
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      final artist = track.artist;

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

    final sortedArtists = artistStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedArtists.take(5).toIList();
  }

  /// Топ треков по количеству прослушиваний
  IList<TrackStats> _getTopTracks(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    final trackStats = <String, TrackStats>{};

    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      final trackKey = '${track.artist} - ${track.title}';

      if (trackStats.containsKey(trackKey)) {
        trackStats[trackKey] = trackStats[trackKey]!.copyWith(
          playCount: trackStats[trackKey]!.playCount + 1,
          totalDuration: trackStats[trackKey]!.totalDuration + track.duration,
        );
      } else {
        trackStats[trackKey] = TrackStats(
          title: track.title,
          artist: track.artist,
          duration: track.duration,
          playCount: 1,
          totalDuration: track.duration,
        );
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
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
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
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      uniqueArtists.add(track.artist);
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
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      totalDuration += track.duration;
    }

    return Duration(seconds: totalDuration ~/ sessions.length);
  }

  /// Статистика по времени суток
  IList<TimeOfDayStats> _getTimeOfDayStats(IList<TrackSession> sessions) {
    final timeStats = <int, TimeOfDayStats>{};

    for (final session in sessions) {
      final hour = DateTime.fromMillisecondsSinceEpoch(
        session.firstObserved,
      ).hour;
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
      final weekday = DateTime.fromMillisecondsSinceEpoch(
        session.firstObserved,
      ).weekday;
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
      final month = DateTime.fromMillisecondsSinceEpoch(
        session.firstObserved,
      ).month;
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
  DateTime? _getMostActiveDay(IList<TrackSession> sessions) {
    if (sessions.isEmpty) return null;

    final dayStats = <DateTime, int>{};

    for (final session in sessions) {
      final day = DateTime.fromMillisecondsSinceEpoch(session.firstObserved);
      final dayStart = DateTime(day.year, day.month, day.day);
      dayStats[dayStart] = (dayStats[dayStart] ?? 0) + 1;
    }

    final mostActiveDay = dayStats.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return mostActiveDay;
  }

  /// Самый длинный трек
  TrackStats? _getLongestTrack(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    if (sessions.isEmpty) return null;

    TrackStats? longestTrack;
    int maxDuration = 0;

    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      if (track.duration > maxDuration) {
        maxDuration = track.duration;
        longestTrack = TrackStats(
          title: track.title,
          artist: track.artist,
          duration: track.duration,
          playCount: 1,
          totalDuration: track.duration,
        );
      }
    }

    return longestTrack;
  }

  /// Самый короткий трек
  TrackStats? _getShortestTrack(
    IList<VkAudioTrack> tracks,
    IList<TrackSession> sessions,
  ) {
    if (sessions.isEmpty) return null;

    TrackStats? shortestTrack;
    int minDuration = 9223372036854775807; // int.maxFinite equivalent

    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      if (track.duration < minDuration) {
        minDuration = track.duration;
        shortestTrack = TrackStats(
          title: track.title,
          artist: track.artist,
          duration: track.duration,
          playCount: 1,
          totalDuration: track.duration,
        );
      }
    }

    return shortestTrack;
  }

  /// Общее количество прослушиваний
  int _getTotalPlayCount(IList<TrackSession> sessions) {
    return sessions.length;
  }
}

// 📊 МОДЕЛИ ДАННЫХ ДЛЯ СТАТИСТИКИ

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
