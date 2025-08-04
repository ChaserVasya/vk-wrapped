import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/domain/services/cache_service_interface.dart';
import 'package:front/data/services/vk_api_service.dart';
import 'package:front/domain/repositories/audio_repository.dart';
import 'package:front/domain/use_cases/get_audio_tracks_use_case.dart';
import 'package:front/domain/use_cases/get_user_audio_use_case.dart';
import 'package:front/ui/blocs/audio_bloc.dart';
import '../mocks/vk_api_service_mock.mocks.dart';
import '../mocks/cache_service_interface_mock.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioBloc Unit Tests', () {
    late MockVkApiService mockVkApiService;
    late MockCacheServiceInterface mockCacheService;
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
    ];

    setUp(() async {
      SharedPreferences.setMockInitialValues({});

      mockVkApiService = MockVkApiService();
      mockCacheService = MockCacheServiceInterface();
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
      when(mockCacheService.cacheTracks(any)).thenAnswer((_) async {});
    });

    tearDown(() {
      audioBloc.close();
    });

    test('should emit loading state initially', () {
      expect(audioBloc.state.tracks.isLoading, isTrue);
    });

    test('should emit data state when loadUserAudio succeeds', () async {
      print('Initial state: ${audioBloc.state.tracks}');

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));

      await Future.delayed(const Duration(milliseconds: 100));

      print('Final state: ${audioBloc.state.tracks}');
      print('Is loading: ${audioBloc.state.tracks.isLoading}');
      print('Is data: ${audioBloc.state.tracks.isData}');
      print('Is error: ${audioBloc.state.tracks.isError}');
      print('Data: ${audioBloc.state.tracks.dataOrNull}');

      expect(audioBloc.state.tracks.isData, isTrue);
      expect(audioBloc.state.tracks.dataOrNull?.length, equals(1));
      expect(
        audioBloc.state.tracks.dataOrNull?.first.title,
        equals('Test Song 1'),
      );
    });

    test('should emit error state when loadUserAudio fails', () async {
      when(
        mockVkApiService.getUserAudio(
          count: anyNamed('count'),
          offset: anyNamed('offset'),
        ),
      ).thenThrow(Exception('Network error'));

      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));

      await Future.delayed(const Duration(milliseconds: 100));

      expect(audioBloc.state.tracks.isError, isTrue);
    });
  });
}
