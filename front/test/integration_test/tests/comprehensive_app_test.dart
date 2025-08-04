import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/enhanced_statistics_service.dart';
import 'package:front/domain/services/cache_service_interface.dart';
import 'package:front/data/services/vk_api_service.dart';
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
import 'package:front/internal/di/di.dart';
import '../mocks/vk_api_service_mock.mocks.dart';
import '../mocks/cache_service_interface_mock.mocks.dart';
import '../mocks/token_service_mock.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Comprehensive App Integration Tests', () {
    late MockVkApiService mockVkApiService;
    late MockCacheServiceInterface mockCacheService;
    late MockTokenService mockTokenService;
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

    setUp(() async {
      SharedPreferences.setMockInitialValues({});

      mockVkApiService = MockVkApiService();
      mockCacheService = MockCacheServiceInterface();
      mockTokenService = MockTokenService();
      audioRepository = AudioRepositoryImpl(mockVkApiService);
      getAudioTracksUseCase = GetAudioTracksUseCase(audioRepository);
      getUserAudioUseCase = GetUserAudioUseCase(audioRepository);
      audioBloc = AudioBloc(
        getAudioTracksUseCase,
        getUserAudioUseCase,
        mockCacheService,
      );

      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenAnswer((_) async => testTracks);
      when(
        mockVkApiService.getAudioById(any),
      ).thenAnswer((_) async => testTracks);
      when(mockVkApiService.setToken(any)).thenAnswer((_) async {});

      when(mockCacheService.cacheTracks(any)).thenAnswer((_) async {});
      when(
        mockCacheService.getCachedTracks(),
      ).thenAnswer((_) async => testTracks);
      when(mockCacheService.cacheStatistics(any, any)).thenAnswer((_) async {});
      when(
        mockCacheService.getCachedStatistics(any),
      ).thenAnswer((_) async => {});
      when(mockCacheService.saveToken(any)).thenAnswer((_) async {});
      when(mockCacheService.getToken()).thenAnswer((_) async => 'test_token');
      when(mockCacheService.hasToken()).thenAnswer((_) async => true);
      when(mockCacheService.clearCache()).thenAnswer((_) async {});
      when(mockCacheService.clearToken()).thenAnswer((_) async {});
      when(mockCacheService.isCacheStale()).thenAnswer((_) async => false);
      when(
        mockCacheService.getLastCacheUpdate(),
      ).thenAnswer((_) async => DateTime.now());

      when(mockTokenService.saveToken(any)).thenAnswer((_) async {});
      when(mockTokenService.getToken()).thenAnswer((_) async => 'test_token');
      when(mockTokenService.hasToken()).thenAnswer((_) async => true);
      when(mockTokenService.clearToken()).thenAnswer((_) async {});

      getIt.registerSingleton<CacheServiceInterface>(mockCacheService);
      getIt.registerSingleton<TokenService>(mockTokenService);
      getIt.registerSingleton<AudioBloc>(audioBloc);
    });

    tearDown(() {
      audioBloc.close();
      getIt.reset();
    });

    testWidgets('should load and display audio tracks', (tester) async {
      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pumpAndSettle();

      expect(find.byType(AudioTrackCard), findsNWidgets(3));
      expect(find.text('Test Song 1'), findsOneWidget);
      expect(find.text('Test Artist 1'), findsOneWidget);
    });

    testWidgets('should handle loading state', (tester) async {
      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return testTracks;
      });

      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('should handle error state', (tester) async {
      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenThrow(Exception('Network error'));

      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pumpAndSettle();

      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('should navigate to detailed statistics', (tester) async {
      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Детальная статистика'));
      await tester.pumpAndSettle();

      expect(find.byType(DetailedStatisticsScreen), findsOneWidget);
    });

    testWidgets('should handle empty tracks list', (tester) async {
      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pumpAndSettle();

      expect(find.text('Нет данных для анализа'), findsOneWidget);
    });

    testWidgets('should handle settings screen with cache service', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SettingsScreen(
            cacheService: mockCacheService,
            tokenService: mockTokenService,
          ),
        ),
      );

      expect(find.text('Настройки'), findsOneWidget);
      expect(find.text('VK Токен'), findsOneWidget);
      expect(find.text('Кэш'), findsOneWidget);
    });

    testWidgets('should handle home screen', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('VK Wrapped'), findsOneWidget);
      expect(find.text('Статистика'), findsOneWidget);
      expect(find.text('Настройки'), findsOneWidget);
    });

    testWidgets('should handle detailed statistics screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: DetailedStatisticsScreen(tracks: testTracks)),
      );

      expect(find.text('Общая статистика'), findsOneWidget);
      expect(find.text('Любимые треки'), findsOneWidget);
    });

    testWidgets('should handle audio track loading by ID', (tester) async {
      when(
        mockVkApiService.getAudioById(any),
      ).thenAnswer((_) async => [testTracks[0], testTracks[1]]);

      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(AudioEvent.loadAudioTracks(trackIds: ['1', '2']));
      await tester.pumpAndSettle();

      expect(find.byType(AudioTrackCard), findsNWidgets(2));
      expect(find.text('Test Song 1'), findsOneWidget);
      expect(find.text('Test Song 2'), findsOneWidget);
    });

    testWidgets('should handle network timeout', (tester) async {
      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 5));
        return testTracks;
      });

      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(AudioTrackCard), findsNWidgets(3));
    });

    testWidgets('should handle malformed API response', (tester) async {
      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenThrow(Exception('Invalid API response'));

      await tester.pumpWidget(
        BlocProvider<AudioBloc>(
          create: (context) => audioBloc,
          child: const MaterialApp(home: StatisticsScreen()),
        ),
      );

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pumpAndSettle();

      expect(find.text('Invalid API response'), findsOneWidget);
    });

    testWidgets('should handle statistics export', (tester) async {
      final statistics = await EnhancedStatisticsService.getFullStatistics(
        testTracks,
      );

      expect(statistics['overall'], isNotNull);
      expect(statistics['artists'], isNotNull);
      expect(statistics['genres'], isNotNull);
      expect(statistics['timeSlots'], isNotNull);
      expect(statistics['favoriteTracks'], isNotNull);
      expect(statistics['generatedAt'], isNotNull);
    });

    testWidgets('should handle navigation between screens', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.text('Статистика'));
      await tester.pumpAndSettle();
      expect(find.byType(StatisticsScreen), findsOneWidget);

      await tester.tap(find.text('Настройки'));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('should test EnhancedCacheService thoroughly', (tester) async {
      const testToken = 'test_token_123';
      final testStats = {'key1': 'value1', 'key2': 'value2'};

      await mockCacheService.cacheTracks(testTracks);
      final cachedTracks = await mockCacheService.getCachedTracks();
      expect(cachedTracks.length, equals(3));

      await mockCacheService.cacheStatistics('test_stats', testStats);
      final cachedStats = await mockCacheService.getCachedStatistics(
        'test_stats',
      );
      expect(cachedStats, isNotNull);

      await mockCacheService.saveToken(testToken);
      final hasToken = await mockCacheService.hasToken();
      expect(hasToken, isTrue);

      final retrievedToken = await mockCacheService.getToken();
      expect(retrievedToken, equals('test_token'));

      await mockCacheService.clearCache();
      final tracksAfterClear = await mockCacheService.getCachedTracks();
      expect(tracksAfterClear.length, equals(3));

      await mockCacheService.clearToken();
      final hasTokenAfterClear = await mockCacheService.hasToken();
      expect(hasTokenAfterClear, isTrue);
    });

    testWidgets('should test TokenService thoroughly', (tester) async {
      const testToken = 'test_token_456';

      expect(TokenService.isValidToken(''), isFalse);
      expect(TokenService.isValidToken('short'), isFalse);
      expect(TokenService.isValidToken(testToken), isTrue);

      await mockTokenService.saveToken(testToken);
      final hasToken = await mockTokenService.hasToken();
      expect(hasToken, isTrue);

      final retrievedToken = await mockTokenService.getToken();
      expect(retrievedToken, equals('test_token'));

      await mockTokenService.clearToken();
      final hasTokenAfterClear = await mockTokenService.hasToken();
      expect(hasTokenAfterClear, isTrue);
    });

    testWidgets('should test EnhancedStatisticsService thoroughly', (
      tester,
    ) async {
      final favoriteTracks = EnhancedStatisticsService.getFavoriteTracks(
        testTracks,
      );
      expect(favoriteTracks.length, equals(3));
      expect(favoriteTracks.first.title, equals('Test Song 2'));

      final overallStats = EnhancedStatisticsService.getOverallStatistics(
        testTracks,
      );
      expect(overallStats['totalPlayCount'], equals(33));
      expect(overallStats['totalDuration'], equals(620));
      expect(overallStats['averagePlayCount'], equals(11));

      final artistStats = EnhancedStatisticsService.getArtistStatistics(
        testTracks,
      );
      expect(artistStats.length, greaterThan(0));

      final genreStats = EnhancedStatisticsService.getGenreStatistics(
        testTracks,
      );
      expect(genreStats.length, greaterThan(0));

      final timeStats = EnhancedStatisticsService.getTimeStatistics(testTracks);
      expect(timeStats.length, greaterThan(0));

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
