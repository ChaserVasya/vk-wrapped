import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/features/state_management/states.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/audio_bloc/audio_bloc.dart';
import 'package:front/ui/screens/detailed_statistics_screen.dart';
import 'package:front/ui/widgets/audio_track_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем данные при инициализации экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<AudioBloc>().add(const AudioEvent.loadUserAudio(count: 50));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AudioBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Статистика')),
        body: BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            print('🔄 UI: State changed - tracks: ${state.tracks.runtimeType}');
            print(
              '🔄 UI: State details - isData: ${state.tracks.isData}, isError: ${state.tracks.isError}, isLoading: ${state.tracks.isLoading}',
            );
            if (state.tracks.isData) {
              print(
                '🔄 UI: Data tracks count: ${state.tracks.dataOrNull?.length ?? 0}',
              );
            }
            return _buildBody(context, state);
          },
        ),
        floatingActionButton: BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'refresh_button',
                  onPressed: () {
                    context.read<AudioBloc>().add(
                      const AudioEvent.loadUserAudio(count: 50),
                    );
                  },
                  child: const Icon(Icons.refresh),
                ),
                if (state.tracks.isData &&
                    (state.tracks.dataOrNull?.isNotEmpty ?? false)) ...[
                  const SizedBox(height: 16),
                  FloatingActionButton.extended(
                    heroTag: 'detailed_stats_button',
                    onPressed: () {
                      final tracks = state.tracks.dataOrNull ?? [];
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailedStatisticsScreen(tracks: tracks),
                        ),
                      );
                    },
                    label: const Text('Детальная статистика'),
                    icon: const Icon(Icons.analytics),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AudioState state) {
    switch (state.tracks) {
      case CommonStateLoading<List<AudioTrack>>():
        return const LoadingState();
      case CommonStateData<List<AudioTrack>>(data: final tracks):
        return tracks.isEmpty
            ? const EmptyState(text: 'Нет данных для анализа')
            : _buildStatisticsPages(tracks);
      case CommonStateError<List<AudioTrack>>(e: final error):
        return ErrorState(
          error?.toString() ?? 'Неизвестная ошибка',
          title: 'Ошибка загрузки данных',
          onRefresh: () {
            context.read<AudioBloc>().add(
              const AudioEvent.loadUserAudio(count: 50),
            );
          },
        );
    }
  }

  Widget _buildStatisticsPages(List<AudioTrack> tracks) {
    return PageView.builder(
      itemCount: _getPageCount(tracks),
      itemBuilder: (context, pageIndex) {
        return _buildStatisticsPage(tracks, pageIndex);
      },
    );
  }

  int _getPageCount(List<AudioTrack> tracks) {
    // Количество страниц: общая статистика + страницы с треками
    const tracksPerPage = 5;
    final tracksPages = (tracks.length / tracksPerPage).ceil();
    return 1 + tracksPages; // 1 для общей статистики + страницы с треками
  }

  Widget _buildStatisticsPage(List<AudioTrack> tracks, int pageIndex) {
    if (pageIndex == 0) {
      return _buildOverviewPage(tracks);
    } else {
      return _buildTracksPage(tracks, pageIndex - 1);
    }
  }

  Widget _buildOverviewPage(List<AudioTrack> tracks) {
    final totalTracks = tracks.length;
    final uniqueArtists = tracks.map((t) => t.artist).toSet().length;
    final totalDuration = tracks.fold<Duration>(
      Duration.zero,
      (total, track) => total + Duration(seconds: track.duration),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Общая статистика',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Карточки статистики
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Всего треков',
                  totalTracks.toString(),
                  Icons.music_note,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Уникальных артистов',
                  uniqueArtists.toString(),
                  Icons.person,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Общее время',
                  _formatDuration(totalDuration),
                  Icons.timer,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Средняя длительность',
                  _formatDuration(
                    Duration(
                      seconds: totalTracks > 0
                          ? totalDuration.inSeconds ~/ totalTracks
                          : 0,
                    ),
                  ),
                  Icons.av_timer,
                  Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Text(
            'Популярные артисты',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Топ артистов
          ..._getTopArtists(tracks)
              .take(5)
              .map(
                (artist) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildArtistCard(artist),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildTracksPage(List<AudioTrack> tracks, int pageIndex) {
    const tracksPerPage = 5;
    final startIndex = pageIndex * tracksPerPage;
    final endIndex = (startIndex + tracksPerPage).clamp(0, tracks.length);
    final pageTracks = tracks.sublist(startIndex, endIndex);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Треки (${startIndex + 1}-$endIndex)',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ...pageTracks.map(
            (track) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AudioTrackCard(
                title: track.title,
                artist: track.artist,
                albumCover: track.albumCover,
                duration: track.duration,
                playCount: track.playCount,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistCard(String artist) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(artist),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '$hoursч $minutesм';
    } else {
      return '$minutesм';
    }
  }

  List<String> _getTopArtists(List<AudioTrack> tracks) {
    final artistCounts = <String, int>{};

    for (final track in tracks) {
      artistCounts[track.artist] = (artistCounts[track.artist] ?? 0) + 1;
    }

    final sortedArtists = artistCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedArtists.map((e) => e.key).toList();
  }
}
