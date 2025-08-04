import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:injectable/injectable.dart';

/// Улучшенный сервис для анализа статистики
@lazySingleton
class StatisticsService {
  /// Анализирует любимые треки
  IList<AudioTrack> getFavoriteTracks(IList<AudioTrack> tracks) {
    final sortedTracks = tracks.sort((a, b) => b.playCount.compareTo(a.playCount));
    return sortedTracks.take(10).toIList();
  }

  /// Анализирует общую статистику
  IMap<String, dynamic> getOverallStatistics(IList<AudioTrack> tracks) {
    if (tracks.isEmpty) {
      return const IMapConst({
        'totalTracks': 0,
        'totalDuration': 0,
        'averageDuration': 0,
        'totalPlayCount': 0,
        'averagePlayCount': 0,
        'totalListeningTime': 0,
      });
    }

    final totalDuration = tracks.fold<int>(
      0,
      (sum, track) => sum + track.duration,
    );
    final totalPlayCount = tracks.fold<int>(
      0,
      (sum, track) => sum + track.playCount,
    );
    final totalListeningTime = totalDuration * totalPlayCount;
    final averageDuration = totalDuration / tracks.length;
    final averagePlayCount = totalPlayCount / tracks.length;

    return IMapConst({
      'totalTracks': tracks.length,
      'totalDuration': totalDuration,
      'averageDuration': averageDuration.round(),
      'totalPlayCount': totalPlayCount,
      'averagePlayCount': averagePlayCount.round(),
      'totalListeningTime': totalListeningTime,
    });
  }

  /// Анализирует статистику по артистам
  IMap<String, int> getArtistStatistics(IList<AudioTrack> tracks) {
    final artistCounts = <String, int>{};

    for (final track in tracks) {
      final artist = track.artist.toLowerCase().trim();
      artistCounts[artist] = (artistCounts[artist] ?? 0) + 1;
    }

    // Сортируем по количеству треков
    final sortedArtists = Map.fromEntries(
      artistCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );

    return sortedArtists.toIMap();
  }

  /// Анализирует статистику по времени прослушивания
  IMap<String, int> getTimeStatistics(IList<AudioTrack> tracks) {
    final timeCounts = <String, int>{};

    for (final track in tracks) {
      if (track.lastPlayed != null) {
        final hour = track.lastPlayed!.hour;
        final timeSlot = _getTimeSlot(hour);
        timeCounts[timeSlot] = (timeCounts[timeSlot] ?? 0) + 1;
      }
    }

    return timeCounts.toIMap();
  }

  /// Получает временной слот
  String _getTimeSlot(int hour) {
    if (hour >= 6 && hour < 12) return 'Утро (6-12)';
    if (hour >= 12 && hour < 18) return 'День (12-18)';
    if (hour >= 18 && hour < 24) return 'Вечер (18-24)';
    return 'Ночь (0-6)';
  }

  /// Анализирует жанры (по названию трека)
  IMap<String, int> getGenreStatistics(IList<AudioTrack> tracks) {
    final genreCounts = <String, int>{};

    for (final track in tracks) {
      final title = track.title.toLowerCase();
      final genre = _detectGenre(title);
      genreCounts[genre] = (genreCounts[genre] ?? 0) + 1;
    }

    // Сортируем по количеству треков
    final sortedGenres = Map.fromEntries(
      genreCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );

    return sortedGenres.toIMap();
  }

  /// Определяет жанр по названию трека
  String _detectGenre(String title) {
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

  /// Получает полную статистику с кэшированием
  Future<IMap<String, dynamic>> getFullStatistics(
    IList<AudioTrack> tracks,
  ) async {
    final overallStats = getOverallStatistics(tracks);
    final artistStats = getArtistStatistics(tracks);
    final genreStats = getGenreStatistics(tracks);
    final timeStats = getTimeStatistics(tracks);
    final favoriteTracks = getFavoriteTracks(tracks);

    final fullStats = IMapConst({
      'overall': overallStats,
      'artists': artistStats,
      'genres': genreStats,
      'timeSlots': timeStats,
      'favoriteTracks': favoriteTracks.map((t) => t.toJson()).toIList(),
      'generatedAt': DateTime.now().toIso8601String(),
    });

    return fullStats;
  }
}
