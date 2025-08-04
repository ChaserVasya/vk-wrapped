import 'package:front/domain/entities/audio_track.dart';

/// Сервис для анализа статистики прослушивания
class StatisticsService {
  /// Анализирует любимые треки
  static List<AudioTrack> getFavoriteTracks(List<AudioTrack> tracks) {
    final sortedTracks = List<AudioTrack>.from(tracks);
    sortedTracks.sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedTracks.take(10).toList();
  }

  /// Анализирует общую статистику
  static Map<String, dynamic> getOverallStatistics(List<AudioTrack> tracks) {
    if (tracks.isEmpty) {
      return {
        'totalTracks': 0,
        'totalDuration': 0,
        'averageDuration': 0,
        'totalPlayCount': 0,
        'averagePlayCount': 0,
      };
    }

    final totalDuration = tracks.fold<int>(
      0,
      (sum, track) => sum + track.duration,
    );
    final totalPlayCount = tracks.fold<int>(
      0,
      (sum, track) => sum + track.playCount,
    );
    final averageDuration = totalDuration / tracks.length;
    final averagePlayCount = totalPlayCount / tracks.length;

    return {
      'totalTracks': tracks.length,
      'totalDuration': totalDuration,
      'averageDuration': averageDuration.round(),
      'totalPlayCount': totalPlayCount,
      'averagePlayCount': averagePlayCount.round(),
    };
  }

  /// Анализирует статистику по артистам
  static Map<String, int> getArtistStatistics(List<AudioTrack> tracks) {
    final artistCounts = <String, int>{};

    for (final track in tracks) {
      final artist = track.artist.toLowerCase().trim();
      artistCounts[artist] = (artistCounts[artist] ?? 0) + 1;
    }

    return artistCounts;
  }

  /// Анализирует статистику по времени прослушивания
  static Map<String, int> getTimeStatistics(List<AudioTrack> tracks) {
    final timeCounts = <String, int>{};

    for (final track in tracks) {
      if (track.lastPlayed != null) {
        final hour = track.lastPlayed!.hour;
        final timeSlot = _getTimeSlot(hour);
        timeCounts[timeSlot] = (timeCounts[timeSlot] ?? 0) + 1;
      }
    }

    return timeCounts;
  }

  /// Получает временной слот
  static String _getTimeSlot(int hour) {
    if (hour >= 6 && hour < 12) return 'Утро (6-12)';
    if (hour >= 12 && hour < 18) return 'День (12-18)';
    if (hour >= 18 && hour < 24) return 'Вечер (18-24)';
    return 'Ночь (0-6)';
  }

  /// Анализирует жанры (по названию трека)
  static Map<String, int> getGenreStatistics(List<AudioTrack> tracks) {
    final genreCounts = <String, int>{};

    for (final track in tracks) {
      final title = track.title.toLowerCase();
      final genre = _detectGenre(title);
      genreCounts[genre] = (genreCounts[genre] ?? 0) + 1;
    }

    return genreCounts;
  }

  /// Определяет жанр по названию трека
  static String _detectGenre(String title) {
    if (title.contains('rock') || title.contains('рок')) return 'Rock';
    if (title.contains('pop') || title.contains('поп')) return 'Pop';
    if (title.contains('rap') || title.contains('хип-хоп')) return 'Hip-Hop';
    if (title.contains('jazz')) return 'Jazz';
    if (title.contains('classic') || title.contains('классика')) {
      return 'Classical';
    }
    if (title.contains('electronic') || title.contains('электро')) {
      return 'Electronic';
    }
    return 'Other';
  }
}
