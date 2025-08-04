import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SimpleDebugWidget extends StatelessWidget {
  final AudioBloc bloc;

  const SimpleDebugWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioBloc>.value(
      value: bloc,
      child: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Text('Tracks Loading: ${state.tracks.isLoading}'),
                Text('Tracks Data: ${state.tracks.isData}'),
                Text('Tracks Error: ${state.tracks.isError}'),
                if (state.tracks.isData) ...[
                  Text('Tracks Count: ${state.tracks.dataOrNull?.length ?? 0}'),
                  if (state.tracks.dataOrNull?.isNotEmpty ?? false)
                    Text(
                      'First Track: ${state.tracks.dataOrNull!.first.title}',
                    ),
                ],
                if (state.tracks.isError) ...[
                  Text(
                    'Error: ${state.tracks.dataOrNull?.toString() ?? "No error"}',
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Simple AudioBloc Tests', () {
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

    testWidgets('should debug state changes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: SimpleDebugWidget(bloc: audioBloc)),
      );

      // Check initial state
      expect(find.text('Tracks Loading: true'), findsOneWidget);
      expect(find.text('Tracks Data: false'), findsOneWidget);
      expect(find.text('Tracks Error: false'), findsOneWidget);

      // Print initial state
      print('Initial state: ${audioBloc.state.tracks}');

      // Add event
      audioBloc.add(const AudioEvent.loadUserAudio(count: 50));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1000));

      // Print final state
      print('Final state: ${audioBloc.state.tracks}');
      print('Is loading: ${audioBloc.state.tracks.isLoading}');
      print('Is data: ${audioBloc.state.tracks.isData}');
      print('Is error: ${audioBloc.state.tracks.isError}');
      print('Data: ${audioBloc.state.tracks.dataOrNull}');

      // Check final state
      expect(find.text('Tracks Loading: false'), findsOneWidget);
      expect(find.text('Tracks Data: true'), findsOneWidget);
      expect(find.text('Tracks Error: false'), findsOneWidget);
      expect(find.text('Tracks Count: 1'), findsOneWidget);
      expect(find.text('First Track: Test Song 1'), findsOneWidget);
    });
  });
}
