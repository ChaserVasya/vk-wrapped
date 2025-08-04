import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/enhanced_statistics_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Working Integration Tests', () {
    late List<AudioTrack> testTracks;

    setUp(() {
      testTracks = [
        AudioTrack(
          id: '1',
          title: 'Rock Song 1',
          artist: 'Rock Artist 1',
          url: 'http://example.com/rock1.mp3',
          duration: 180,
          albumCover: 'http://example.com/cover1.jpg',
          playCount: 15,
          lastPlayed: DateTime.now(),
        ),
        AudioTrack(
          id: '2',
          title: 'Pop Song 1',
          artist: 'Pop Artist 1',
          url: 'http://example.com/pop1.mp3',
          duration: 200,
          albumCover: 'http://example.com/cover2.jpg',
          playCount: 10,
          lastPlayed: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        AudioTrack(
          id: '3',
          title: 'Jazz Song 1',
          artist: 'Jazz Artist 1',
          url: 'http://example.com/jazz1.mp3',
          duration: 300,
          albumCover: 'http://example.com/cover3.jpg',
          playCount: 5,
          lastPlayed: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      ];
    });

    test('should get favorite tracks correctly', () {
      // Act
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(
        testTracks,
      );

      // Assert
      expect(favoriteTracks.length, equals(3));
      expect(
        favoriteTracks.first.title,
        equals('Rock Song 1'),
      ); // Highest play count
      expect(favoriteTracks.first.playCount, equals(15));
      expect(
        favoriteTracks.last.title,
        equals('Jazz Song 1'),
      ); // Lowest play count
      expect(favoriteTracks.last.playCount, equals(5));
    });

    test('should get overall statistics correctly', () {
      // Act
      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        testTracks,
      );

      // Assert
      expect(overallStats['totalTracks'], equals(3));
      expect(overallStats['totalDuration'], equals(680)); // 180 + 200 + 300
      expect(overallStats['averageDuration'], equals(227)); // 680 / 3
      expect(overallStats['totalPlayCount'], equals(30)); // 15 + 10 + 5
      expect(overallStats['averagePlayCount'], equals(10)); // 30 / 3
      expect(overallStats['totalListeningTime'], equals(20400)); // 680 * 30
    });

    test('should get artist statistics correctly', () {
      // Act
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        testTracks,
      );

      // Assert
      expect(artistStats.length, equals(3));
      expect(artistStats['rock artist 1'], equals(1));
      expect(artistStats['pop artist 1'], equals(1));
      expect(artistStats['jazz artist 1'], equals(1));
    });

    test('should get genre statistics correctly', () {
      // Act
      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        testTracks,
      );

      // Assert
      expect(genreStats.length, equals(3));
      expect(genreStats['Rock'], equals(1));
      expect(genreStats['Pop'], equals(1));
      expect(genreStats['Jazz'], equals(1));
    });

    test('should get time statistics correctly', () {
      // Act
      final timeStats = EnhancedStatisticsService.getTimeStatistics(testTracks);

      // Assert
      expect(timeStats.length, greaterThan(0));
      expect(timeStats.values.every((count) => count >= 0), isTrue);
    });

    test('should handle empty tracks list', () {
      // Act
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks([]);
      final overallStats = EnhancedStatisticsService.getOverallStatistics([]);
      final artistStats = EnhancedStatisticsService.getArtistStatistics([]);
      final genreStats = EnhancedStatisticsService.getGenreStatistics([]);
      final timeStats = EnhancedStatisticsService.getTimeStatistics([]);

      // Assert
      expect(favoriteTracks, isEmpty);
      expect(overallStats['totalTracks'], equals(0));
      expect(overallStats['totalDuration'], equals(0));
      expect(artistStats, isEmpty);
      expect(genreStats, isEmpty);
      expect(timeStats, isEmpty);
    });

    test('should handle tracks with null lastPlayed', () {
      // Arrange
      final tracksWithNullLastPlayed = [
        AudioTrack(
          id: '1',
          title: 'Test Song',
          artist: 'Test Artist',
          url: 'http://example.com/test.mp3',
          duration: 180,
          albumCover: 'http://example.com/cover.jpg',
          playCount: 10,
          lastPlayed: null,
        ),
      ];

      // Act
      final timeStats = EnhancedStatisticsService.getTimeStatistics(
        tracksWithNullLastPlayed,
      );

      // Assert
      expect(timeStats, isEmpty);
    });

    test('should handle tracks with special characters in titles', () {
      // Arrange
      final specialTracks = [
        AudioTrack(
          id: '1',
          title: 'Классическая музыка',
          artist: 'Классический артист',
          url: 'http://example.com/classic.mp3',
          duration: 300,
          albumCover: 'http://example.com/cover.jpg',
          playCount: 10,
          lastPlayed: DateTime.now(),
        ),
        AudioTrack(
          id: '2',
          title: 'Electronic music',
          artist: 'Electronic artist',
          url: 'http://example.com/electronic.mp3',
          duration: 200,
          albumCover: 'http://example.com/cover2.jpg',
          playCount: 5,
          lastPlayed: DateTime.now(),
        ),
      ];

      // Act
      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        specialTracks,
      );

      // Assert
      expect(genreStats['Electronic'], equals(1));
      expect(genreStats.length, greaterThan(0));
    });

    test('should handle tracks with same artist but different casing', () {
      // Arrange
      final tracksWithSameArtist = [
        AudioTrack(
          id: '1',
          title: 'Song 1',
          artist: 'Artist Name',
          url: 'http://example.com/song1.mp3',
          duration: 180,
          albumCover: 'http://example.com/cover1.jpg',
          playCount: 10,
          lastPlayed: DateTime.now(),
        ),
        AudioTrack(
          id: '2',
          title: 'Song 2',
          artist: 'ARTIST NAME',
          url: 'http://example.com/song2.mp3',
          duration: 200,
          albumCover: 'http://example.com/cover2.jpg',
          playCount: 5,
          lastPlayed: DateTime.now(),
        ),
      ];

      // Act
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        tracksWithSameArtist,
      );

      // Assert
      expect(artistStats.length, equals(1));
      expect(
        artistStats['artist name'],
        equals(2),
      ); // Both tracks counted as same artist
    });

    test('should calculate total listening time correctly', () {
      // Act
      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        testTracks,
      );

      // Assert
      final totalDuration = overallStats['totalDuration'] as int;
      final totalPlayCount = overallStats['totalPlayCount'] as int;
      final totalListeningTime = overallStats['totalListeningTime'] as int;

      expect(totalListeningTime, equals(totalDuration * totalPlayCount));
    });

    test('should sort favorite tracks by play count descending', () {
      // Act
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(
        testTracks,
      );

      // Assert
      expect(favoriteTracks.length, equals(3));
      expect(favoriteTracks[0].playCount, equals(15)); // Highest
      expect(favoriteTracks[1].playCount, equals(10)); // Middle
      expect(favoriteTracks[2].playCount, equals(5)); // Lowest
    });

    test('should handle single track correctly', () {
      // Arrange
      final singleTrack = [testTracks.first];

      // Act
      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        singleTrack,
      );
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        singleTrack,
      );
      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        singleTrack,
      );

      // Assert
      expect(overallStats['totalTracks'], equals(1));
      expect(overallStats['totalDuration'], equals(180));
      expect(overallStats['averageDuration'], equals(180));
      expect(overallStats['totalPlayCount'], equals(15));
      expect(overallStats['averagePlayCount'], equals(15));

      expect(artistStats.length, equals(1));
      expect(artistStats['rock artist 1'], equals(1));

      expect(genreStats.length, equals(1));
      expect(genreStats['Rock'], equals(1));
    });
  });
}
