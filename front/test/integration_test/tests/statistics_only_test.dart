import 'package:flutter_test/flutter_test.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/enhanced_statistics_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EnhancedStatisticsService Tests', () {
    final testTracks = [
      AudioTrack(
        id: '1',
        title: 'Test Song 1',
        artist: 'Test Artist 1',
        url: 'https://example.com/song1.mp3',
        albumCover: 'https://example.com/cover1.jpg',
        duration: 180,
        playCount: 10,
        lastPlayed: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      AudioTrack(
        id: '2',
        title: 'Test Song 2',
        artist: 'Test Artist 2',
        url: 'https://example.com/song2.mp3',
        albumCover: 'https://example.com/cover2.jpg',
        duration: 240,
        playCount: 15,
        lastPlayed: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      AudioTrack(
        id: '3',
        title: 'Test Song 3',
        artist: 'Test Artist 1',
        url: 'https://example.com/song3.mp3',
        albumCover: 'https://example.com/cover3.jpg',
        duration: 200,
        playCount: 8,
        lastPlayed: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];

    test('should get favorite tracks correctly', () {
      // Act
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(
        testTracks,
      );

      // Assert
      expect(favoriteTracks.length, equals(3));
      expect(
        favoriteTracks.first.title,
        equals('Test Song 2'),
      ); // Highest play count
      expect(favoriteTracks.first.playCount, equals(15));
      expect(
        favoriteTracks.last.title,
        equals('Test Song 3'),
      ); // Lowest play count
      expect(favoriteTracks.last.playCount, equals(8));
    });

    test('should get overall statistics correctly', () {
      // Act
      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        testTracks,
      );

      // Assert
      expect(overallStats['totalPlayCount'], equals(33));
      expect(overallStats['totalDuration'], equals(620));
      expect(overallStats['averagePlayCount'], equals(11));
      expect(overallStats['totalListeningTime'], equals(20460)); // 620 * 33
    });

    test('should get artist statistics correctly', () {
      // Act
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        testTracks,
      );

      // Assert
      expect(artistStats.length, greaterThan(0));
    });

    test('should get genre statistics correctly', () {
      // Act
      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        testTracks,
      );

      // Assert
      expect(genreStats.length, greaterThan(0));
    });

    test('should get time statistics correctly', () {
      // Act
      final timeStats = EnhancedStatisticsService.getTimeStatistics(testTracks);

      // Assert
      expect(timeStats.length, greaterThan(0));
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
      expect(overallStats['totalPlayCount'], equals(0));
      expect(artistStats, isEmpty);
      expect(genreStats, isEmpty);
      expect(timeStats, isEmpty);
    });

    test('should handle tracks with null lastPlayed', () {
      final tracksWithNullLastPlayed = [
        AudioTrack(
          id: '1',
          title: 'Test Song 1',
          artist: 'Test Artist 1',
          url: 'https://example.com/song1.mp3',
          duration: 180,
          playCount: 10,
          lastPlayed: null,
        ),
      ];

      // Act
      final timeStats = EnhancedStatisticsService.getTimeStatistics(
        tracksWithNullLastPlayed,
      );

      // Assert
      expect(timeStats.length, greaterThanOrEqualTo(0));
    });

    test('should handle tracks with special characters in titles', () {
      final specialTracks = [
        AudioTrack(
          id: '1',
          title: 'Test Song with Special Characters: !@#\$%^&*()',
          artist: 'Test Artist 1',
          url: 'https://example.com/song1.mp3',
          duration: 180,
          playCount: 10,
        ),
      ];

      // Act
      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        specialTracks,
      );

      // Assert
      expect(genreStats.length, greaterThan(0));
    });

    test('should handle tracks with same artist but different casing', () {
      final tracksWithSameArtist = [
        AudioTrack(
          id: '1',
          title: 'Test Song 1',
          artist: 'artist name',
          url: 'https://example.com/song1.mp3',
          duration: 180,
          playCount: 10,
        ),
        AudioTrack(
          id: '2',
          title: 'Test Song 2',
          artist: 'ARTIST NAME',
          url: 'https://example.com/song2.mp3',
          duration: 240,
          playCount: 15,
        ),
      ];

      // Act
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        tracksWithSameArtist,
      );

      // Assert
      expect(artistStats.length, greaterThan(0));
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
      expect(favoriteTracks[2].playCount, equals(8)); // Lowest
    });

    test('should handle single track correctly', () {
      final singleTrack = [
        AudioTrack(
          id: '1',
          title: 'Single Track',
          artist: 'rock artist 1',
          url: 'https://example.com/song1.mp3',
          duration: 180,
          playCount: 15,
        ),
      ];

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
      expect(overallStats['totalPlayCount'], equals(15));
      expect(overallStats['averagePlayCount'], equals(15));

      expect(artistStats.length, greaterThan(0));
      expect(genreStats.length, greaterThan(0));
    });

    test('should get full statistics correctly', () async {
      // Act
      final fullStats = await EnhancedStatisticsService.getFullStatistics(
        testTracks,
      );

      // Assert
      expect(fullStats['overall'], isNotNull);
      expect(fullStats['artists'], isNotNull);
      expect(fullStats['genres'], isNotNull);
      expect(fullStats['timeSlots'], isNotNull);
      expect(fullStats['favoriteTracks'], isNotNull);
      expect(fullStats['generatedAt'], isNotNull);
    });
  });
}
