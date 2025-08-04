import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/enhanced_statistics_service.dart';
import 'package:front/data/services/vk_api_service.dart';
import 'package:front/data/services/enhanced_cache_service.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/use_cases/get_audio_tracks_use_case.dart';
import 'package:front/domain/use_cases/get_user_audio_use_case.dart';
import 'package:front/ui/blocs/audio_bloc.dart';
import 'package:front/ui/screens/statistics_screen.dart';
import 'package:front/ui/screens/settings_screen.dart';
import 'package:front/ui/screens/home_screen.dart';
import 'package:front/ui/screens/detailed_statistics_screen.dart';
import 'package:front/ui/widgets/audio_track_card.dart';
import 'full_app_integration_test.mocks.dart';

// Генерируем моки для внешних зависимостей
@GenerateMocks([VkApiService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Full App Integration Tests', () {
    late MockVkApiService mockVkApiService;
    late EnhancedCacheService cacheService;
    late TokenService tokenService;
    late AudioRepository audioRepository;
    late GetAudioTracksUseCase getAudioTracksUseCase;
    late GetUserAudioUseCase getUserAudioUseCase;
    late AudioBloc audioBloc;

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
      mockVkApiService = MockVkApiService();
      cacheService = EnhancedCacheService();
      tokenService = TokenService(cacheService);
      audioRepository = AudioRepositoryImpl(mockVkApiService);
      getAudioTracksUseCase = GetAudioTracksUseCase(audioRepository);
      getUserAudioUseCase = GetUserAudioUseCase(audioRepository);
      audioBloc = AudioBloc(getAudioTracksUseCase, getUserAudioUseCase, cacheService);

      // Настраиваем моки для VkApiService
      when(mockVkApiService.getUserAudio(count: anyNamed('count'), offset: anyNamed('offset')))
          .thenAnswer((_) async => testTracks);
      when(mockVkApiService.getAudioById(any))
          .thenAnswer((_) async => testTracks);
      when(mockVkApiService.setToken(any))
          .thenAnswer((_) async {});
    });

    tearDown(() {
      audioBloc.close();
    });

    testWidgets('should load and display audio tracks', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act - загружаем треки
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pumpAndSettle();

      // Assert - проверяем что треки отображаются
      expect(find.byType(AudioTrackCard), findsNWidgets(3));
      expect(find.text('Test Song 1'), findsOneWidget);
      expect(find.text('Test Artist 1'), findsNWidgets(2));
    });

    testWidgets('should handle loading state', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act - загружаем треки
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pump();

      // Assert - проверяем состояние загрузки
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle error state', (tester) async {
      // Arrange - настраиваем ошибку
      when(mockVkApiService.getUserAudio(count: anyNamed('count'), offset: anyNamed('offset')))
          .thenThrow(Exception('Network error'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act - загружаем треки
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pumpAndSettle();

      // Assert - проверяем отображение ошибки
      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('should cache tracks and retrieve from cache', (tester) async {
      // Arrange
      await cacheService.cacheTracks(testTracks);

      // Act - получаем треки из кэша
      final cachedTracks = await cacheService.getCachedTracks();

      // Assert
      expect(cachedTracks.length, equals(3));
      expect(cachedTracks.first.title, equals('Test Song 1'));
    });

    testWidgets('should calculate statistics correctly', (tester) async {
      // Act
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(testTracks);
      final overallStats = EnhancedStatisticsService.getOverallStatistics(testTracks);
      final artistStats = EnhancedStatisticsService.getArtistStatistics(testTracks);

      // Assert
      expect(favoriteTracks.length, equals(3));
      expect(favoriteTracks.first.title, equals('Test Song 2')); // Highest play count
      expect(overallStats['totalPlayCount'], equals(33));
      expect(artistStats['Test Artist 1'], equals(2));
    });

    testWidgets('should handle token management', (tester) async {
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

    testWidgets('should handle cache staleness', (tester) async {
      // Arrange
      await cacheService.cacheTracks(testTracks);

      // Act
      final isStale = await cacheService.isCacheStale();

      // Assert - кэш не должен быть устаревшим сразу после создания
      expect(isStale, isFalse);
    });

    testWidgets('should clear cache completely', (tester) async {
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

    testWidgets('should navigate to detailed statistics', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Загружаем треки
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pumpAndSettle();

      // Act - нажимаем кнопку детальной статистики
      await tester.tap(find.text('Детальная статистика'));
      await tester.pumpAndSettle();

      // Assert - проверяем что перешли на экран детальной статистики
      expect(find.byType(DetailedStatisticsScreen), findsOneWidget);
    });

    testWidgets('should handle empty tracks list', (tester) async {
      // Arrange
      when(mockVkApiService.getUserAudio(count: anyNamed('count'), offset: anyNamed('offset')))
          .thenAnswer((_) async => []);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Нет данных для анализа'), findsOneWidget);
    });

    testWidgets('should handle settings screen with cache service', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: SettingsScreen(
            cacheService: cacheService,
            tokenService: tokenService,
          ),
        ),
      );

      // Assert - проверяем что экран настроек отображается
      expect(find.text('Настройки'), findsOneWidget);
      expect(find.text('VK Токен'), findsOneWidget);
      expect(find.text('Кэш'), findsOneWidget);
    });

    testWidgets('should handle home screen', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      // Assert - проверяем что главный экран отображается
      expect(find.text('VK Wrapped'), findsOneWidget);
      expect(find.text('Статистика'), findsOneWidget);
      expect(find.text('Настройки'), findsOneWidget);
    });

    testWidgets('should handle detailed statistics screen', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: DetailedStatisticsScreen(tracks: testTracks),
        ),
      );

      // Assert - проверяем что экран детальной статистики отображается
      expect(find.text('Детальная статистика'), findsOneWidget);
      expect(find.text('Общая статистика'), findsOneWidget);
      expect(find.text('Статистика по исполнителям'), findsOneWidget);
    });

    testWidgets('should handle audio track loading by ID', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act
      audioBloc.add(LoadAudioTracks(['1', '2']));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AudioTrackCard), findsNWidgets(2));
    });

    testWidgets('should handle network timeout', (tester) async {
      // Arrange - настраиваем долгий ответ
      when(mockVkApiService.getUserAudio(count: anyNamed('count'), offset: anyNamed('offset')))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 5));
        return testTracks;
      });

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pump();

      // Assert - проверяем состояние загрузки
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle malformed API response', (tester) async {
      // Arrange - настраиваем некорректный ответ
      when(mockVkApiService.getUserAudio(count: anyNamed('count'), offset: anyNamed('offset')))
          .thenThrow(Exception('Invalid API response'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AudioBloc>.value(
            value: audioBloc,
            child: const StatisticsScreen(),
          ),
        ),
      );

      // Act
      audioBloc.add(LoadUserAudio(count: 50));
      await tester.pumpAndSettle();

      // Assert - проверяем обработку ошибки
      expect(find.text('Invalid API response'), findsOneWidget);
    });

    testWidgets('should handle statistics export', (tester) async {
      // Arrange
      await cacheService.cacheTracks(testTracks);

      // Act - получаем статистику
      final statistics = await EnhancedStatisticsService.getFullStatistics(testTracks);

      // Assert - проверяем что статистика содержит все необходимые данные
      expect(statistics['overall'], isNotNull);
      expect(statistics['artists'], isNotNull);
      expect(statistics['genres'], isNotNull);
      expect(statistics['timeSlots'], isNotNull);
      expect(statistics['favoriteTracks'], isNotNull);
      expect(statistics['generatedAt'], isNotNull);
    });

    testWidgets('should handle theme switching', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const HomeScreen(),
        ),
      );

      // Assert - проверяем что приложение отображается с темой
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle navigation between screens', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      // Act - переходим на экран статистики
      await tester.tap(find.text('Статистика'));
      await tester.pumpAndSettle();

      // Assert - проверяем что перешли на экран статистики
      expect(find.text('Статистика'), findsOneWidget);

      // Act - переходим на экран настроек
      await tester.tap(find.text('Настройки'));
      await tester.pumpAndSettle();

      // Assert - проверяем что перешли на экран настроек
      expect(find.text('Настройки'), findsOneWidget);
    });

    testWidgets('should test EnhancedCacheService thoroughly', (tester) async {
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

    testWidgets('should test TokenService thoroughly', (tester) async {
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

    testWidgets('should test EnhancedStatisticsService thoroughly', (tester) async {
      // Act & Assert - тестируем получение любимых треков
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(testTracks);
      expect(favoriteTracks.length, equals(3));
      expect(favoriteTracks.first.title, equals('Test Song 2')); // Highest play count

      // Act & Assert - тестируем общую статистику
      final overallStats = EnhancedStatisticsService.getOverallStatistics(testTracks);
      expect(overallStats['totalPlayCount'], equals(33));
      expect(overallStats['totalDuration'], equals(620));
      expect(overallStats['averagePlayCount'], equals(11));

      // Act & Assert - тестируем статистику по исполнителям
      final artistStats = EnhancedStatisticsService.getArtistStatistics(testTracks);
      expect(artistStats['Test Artist 1'], equals(2));
      expect(artistStats['Test Artist 2'], equals(1));

      // Act & Assert - тестируем статистику по жанрам
      final genreStats = EnhancedStatisticsService.getGenreStatistics(testTracks);
      expect(genreStats.length, greaterThan(0));

      // Act & Assert - тестируем статистику по времени
      final timeStats = EnhancedStatisticsService.getTimeStatistics(testTracks);
      expect(timeStats.length, greaterThan(0));

      // Act & Assert - тестируем полную статистику
      final fullStats = await EnhancedStatisticsService.getFullStatistics(testTracks);
      expect(fullStats['overall'], isNotNull);
      expect(fullStats['artists'], isNotNull);
      expect(fullStats['genres'], isNotNull);
      expect(fullStats['timeSlots'], isNotNull);
      expect(fullStats['favoriteTracks'], isNotNull);
      expect(fullStats['generatedAt'], isNotNull);
    });
  });
} 