import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/enhanced_statistics_service.dart';
import 'package:front/data/services/enhanced_cache_service.dart';
import 'package:front/data/services/token_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Simple App Integration Tests', () {
    late EnhancedCacheService cacheService;
    late TokenService tokenService;

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

    setUp(() {
      cacheService = EnhancedCacheService();
      tokenService = TokenService(cacheService);
    });

    test('should cache tracks and retrieve from cache', () async {
      // Arrange
      await cacheService.cacheTracks(testTracks);

      // Act - получаем треки из кэша
      final cachedTracks = await cacheService.getCachedTracks();

      // Assert
      expect(cachedTracks.length, equals(3));
      expect(cachedTracks.first.title, equals('Test Song 1'));
    });

    test('should calculate statistics correctly', () async {
      // Act
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(
        testTracks,
      );
      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        testTracks,
      );
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        testTracks,
      );

      // Assert
      expect(favoriteTracks.length, equals(3));
      expect(
        favoriteTracks.first.title,
        equals('Test Song 2'),
      ); // Highest play count
      expect(overallStats['totalPlayCount'], equals(33));
      expect(artistStats['Test Artist 1'], equals(2));
    });

    test('should handle token management', () async {
      // Arrange
      const testToken = 'test_vk_token_123';

      // Act
      await tokenService.saveToken(testToken);
      final hasToken = await tokenService.hasToken();
      final retrievedToken = await tokenService.getToken();

      // Assert
      expect(hasToken, isTrue);
      expect(retrievedToken, equals(testToken));

      // Act - очищаем токен
      await tokenService.clearToken();
      final hasTokenAfterClear = await tokenService.hasToken();

      // Assert
      expect(hasTokenAfterClear, isFalse);
    });

    test('should handle cache staleness', () async {
      // Arrange
      await cacheService.cacheTracks(testTracks);

      // Act
      final isStale = await cacheService.isCacheStale();

      // Assert - кэш не должен быть устаревшим сразу после создания
      expect(isStale, isFalse);
    });

    test('should clear cache completely', () async {
      // Arrange
      await cacheService.cacheTracks(testTracks);
      await cacheService.cacheStatistics('test_key', {'test': 'data'});

      // Act
      await cacheService.clearCache();
      final cachedTracks = await cacheService.getCachedTracks();
      final cachedStats = await cacheService.getCachedStatistics('test_key');

      // Assert
      expect(cachedTracks, isEmpty);
      expect(cachedStats, isNull);
    });

    test('should handle statistics export', () async {
      // Arrange
      await cacheService.cacheTracks(testTracks);

      // Act - получаем статистику
      final statistics = await EnhancedStatisticsService.getFullStatistics(
        testTracks,
      );

      // Assert - проверяем что статистика содержит все необходимые данные
      expect(statistics['overall'], isNotNull);
      expect(statistics['artists'], isNotNull);
      expect(statistics['genres'], isNotNull);
      expect(statistics['timeSlots'], isNotNull);
      expect(statistics['favoriteTracks'], isNotNull);
      expect(statistics['generatedAt'], isNotNull);
    });

    test('should test EnhancedCacheService thoroughly', () async {
      // Arrange
      const testToken = 'test_token_123';
      final testStats = {'key1': 'value1', 'key2': 'value2'};

      // Act & Assert - тестируем кэширование треков
      await cacheService.cacheTracks(testTracks);
      final cachedTracks = await cacheService.getCachedTracks();
      expect(cachedTracks.length, equals(3));

      // Act & Assert - тестируем кэширование статистики
      await cacheService.cacheStatistics('test_stats', testStats);
      final cachedStats = await cacheService.getCachedStatistics('test_stats');
      expect(cachedStats, isNotNull);

      // Act & Assert - тестируем управление токенами
      await cacheService.saveToken(testToken);
      final hasToken = await cacheService.hasToken();
      expect(hasToken, isTrue);

      final retrievedToken = await cacheService.getToken();
      expect(retrievedToken, equals(testToken));

      // Act & Assert - тестируем очистку кэша
      await cacheService.clearCache();
      final tracksAfterClear = await cacheService.getCachedTracks();
      expect(tracksAfterClear, isEmpty);

      // Act & Assert - тестируем очистку токена
      await cacheService.clearToken();
      final hasTokenAfterClear = await cacheService.hasToken();
      expect(hasTokenAfterClear, isFalse);
    });

    test('should test TokenService thoroughly', () async {
      // Arrange
      const testToken = 'test_token_456';

      // Act & Assert - тестируем валидацию токенов
      expect(TokenService.isValidToken(''), isFalse);
      expect(TokenService.isValidToken('short'), isFalse);
      expect(TokenService.isValidToken(testToken), isTrue);

      // Act & Assert - тестируем сохранение и получение токенов
      await tokenService.saveToken(testToken);
      final hasToken = await tokenService.hasToken();
      expect(hasToken, isTrue);

      final retrievedToken = await tokenService.getToken();
      expect(retrievedToken, equals(testToken));

      // Act & Assert - тестируем очистку токенов
      await tokenService.clearToken();
      final hasTokenAfterClear = await tokenService.hasToken();
      expect(hasTokenAfterClear, isFalse);
    });

    test('should test EnhancedStatisticsService thoroughly', () async {
      // Act & Assert - тестируем получение любимых треков
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(
        testTracks,
      );
      expect(favoriteTracks.length, equals(3));
      expect(
        favoriteTracks.first.title,
        equals('Test Song 2'),
      ); // Highest play count

      // Act & Assert - тестируем общую статистику
      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        testTracks,
      );
      expect(overallStats['totalPlayCount'], equals(33));
      expect(overallStats['totalDuration'], equals(620));
      expect(overallStats['averagePlayCount'], equals(11));

      // Act & Assert - тестируем статистику по исполнителям
      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        testTracks,
      );
      expect(artistStats['Test Artist 1'], equals(2));
      expect(artistStats['Test Artist 2'], equals(1));

      // Act & Assert - тестируем статистику по жанрам
      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        testTracks,
      );
      expect(genreStats.length, greaterThan(0));

      // Act & Assert - тестируем статистику по времени
      final timeStats = EnhancedStatisticsService.getTimeStatistics(testTracks);
      expect(timeStats.length, greaterThan(0));

      // Act & Assert - тестируем полную статистику
      final fullStats = await EnhancedStatisticsService.getFullStatistics(
        testTracks,
      );
      expect(fullStats['overall'], isNotNull);
      expect(fullStats['artists'], isNotNull);
      expect(fullStats['genres'], isNotNull);
      expect(fullStats['timeSlots'], isNotNull);
      expect(fullStats['favoriteTracks'], isNotNull);
      expect(fullStats['generatedAt'], isNotNull);
    });
  });
}
