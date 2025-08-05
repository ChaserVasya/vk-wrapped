import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/domain/entities/track_session.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsService {
  final AudioRepository _audioRepository;

  StatisticsService(this._audioRepository);

  // 🎵 МУЗЫКАЛЬНАЯ СТАТИСТИКА

  /// Топ исполнителей по количеству прослушиваний
  Future<IList<ArtistStats>> getTopArtists() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

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
  Future<IList<TrackStats>> getTopTracks() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

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
  Future<Duration> getTotalListeningTime() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

    int totalSeconds = 0;
    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      totalSeconds += track.duration;
    }

    return Duration(seconds: totalSeconds);
  }

  /// Количество уникальных треков
  Future<int> getUniqueTracksCount() async {
    final sessions = await _getSessions();

    final uniqueTrackIds = sessions.map((s) => s.fullId).toSet();
    return uniqueTrackIds.length;
  }

  /// Количество уникальных исполнителей
  Future<int> getUniqueArtistsCount() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

    final uniqueArtists = <String>{};
    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      uniqueArtists.add(track.artist);
    }

    return uniqueArtists.length;
  }

  /// Средняя продолжительность трека
  Future<Duration> getAverageTrackDuration() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

    if (sessions.isEmpty) return Duration.zero;

    int totalDuration = 0;
    int trackCount = 0;

    for (final session in sessions) {
      final track = tracks.firstWhere((t) => t.fullId == session.fullId);
      totalDuration += track.duration;
      trackCount++;
    }

    return Duration(seconds: totalDuration ~/ trackCount);
  }

  /// Статистика по времени суток
  Future<IList<TimeOfDayStats>> getTimeOfDayStats() async {
    final sessions = await _getSessions();

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

    final sortedTimeStats = timeStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedTimeStats.toIList();
  }

  /// Статистика по дням недели
  Future<IList<DayOfWeekStats>> getDayOfWeekStats() async {
    final sessions = await _getSessions();

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

    final sortedDayStats = dayStats.values.toList()
      ..sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedDayStats.toIList();
  }

  /// Статистика по месяцам
  Future<IList<MonthStats>> getMonthStats() async {
    final sessions = await _getSessions();

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

    final sortedMonthStats = monthStats.values.toList()
      ..sort((a, b) => a.month.compareTo(b.month));
    return sortedMonthStats.toIList();
  }

  /// Самый активный день
  Future<DateTime?> getMostActiveDay() async {
    final sessions = await _getSessions();

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
  Future<TrackStats?> getLongestTrack() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

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
  Future<TrackStats?> getShortestTrack() async {
    final tracks = await _audioRepository.getListenedAudio();
    final sessions = await _getSessions();

    if (sessions.isEmpty) return null;

    TrackStats? shortestTrack;
    int minDuration = double.maxFinite.toInt();

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
  Future<int> getTotalPlayCount() async {
    final sessions = await _getSessions();
    return sessions.length;
  }

  // 📊 ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ

  Future<IList<TrackSession>> _getSessions() async {
    return _audioRepository.getSessions();
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
