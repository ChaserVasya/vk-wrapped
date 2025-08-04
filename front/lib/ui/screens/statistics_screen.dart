import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/ui/blocs/audio_bloc/audio_bloc.dart';
import 'package:front/ui/widgets/audio_track_card.dart';
import 'package:front/features/state_management/states.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/ui/screens/detailed_statistics_screen.dart';
import 'package:front/domain/entities/audio_track.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
      floatingActionButton: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
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
    );
  }

  Widget _buildBody(BuildContext context, AudioState state) {
    switch (state.tracks) {
      case CommonStateLoading<List<AudioTrack>>():
        return const LoadingState();
      case CommonStateData<List<AudioTrack>>(data: final tracks):
        return tracks.isEmpty
            ? const EmptyState(text: 'Нет данных для анализа')
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AudioTrackCard(
                      title: track.title,
                      artist: track.artist,
                      albumCover: track.albumCover,
                      duration: track.duration,
                      playCount: track.playCount,
                    ),
                  );
                },
              );
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
}
