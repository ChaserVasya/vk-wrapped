import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/entities/audio_track.dart';
import 'package:front/features/state_management/states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/detailed_statistics_bloc/detailed_statistics_bloc.dart';

class DetailedStatisticsScreen extends StatelessWidget {
  final List<AudioTrack> tracks;

  const DetailedStatisticsScreen({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<DetailedStatisticsBloc>();
        if (tracks.isNotEmpty) {
          bloc.add(DetailedStatisticsEvent.loadStatistics(tracks));
        } else {
          // Если треки не переданы, загружаем из кэша
          bloc.add(DetailedStatisticsEvent.loadFromCache());
        }
        return bloc;
      },
      child: EffectListener<DetailedStatisticsBloc, DetailedStatisticsEffect>(
        listener: (context, effect) {
          switch (effect) {
            case DetailedStatisticsEffect$Error(message: final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Ошибка: $message')));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Детальная статистика'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<DetailedStatisticsBloc>().add(
                    DetailedStatisticsEvent.loadStatistics(tracks),
                  );
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: BlocBuilder<DetailedStatisticsBloc, DetailedStatisticsState>(
            builder: (context, state) {
              return _buildBody(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DetailedStatisticsState state) {
    switch (state) {
      case DetailedStatisticsState$Loading():
        return const LoadingState();
      case DetailedStatisticsState$Error(message: final message):
        return ErrorState(
          message,
          onRefresh: () {
            context.read<DetailedStatisticsBloc>().add(
              DetailedStatisticsEvent.loadStatistics(tracks),
            );
          },
        );
      case DetailedStatisticsState$Data(statistics: final statistics):
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverallSection(statistics),
              const SizedBox(height: 24),
              _buildFavoriteTracksSection(statistics),
              const SizedBox(height: 24),
              _buildArtistSection(statistics),
              const SizedBox(height: 24),
              _buildGenreSection(statistics),
              const SizedBox(height: 24),
              _buildTimeSection(statistics),
            ],
          ),
        );
      default:
        return const EmptyState(text: 'Статистика не найдена');
    }
  }

  Widget _buildOverallSection(Map<String, dynamic> statistics) {
    final overall = statistics['overall'] as Map<String, dynamic>;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Общая статистика',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatRow('Всего треков', overall['totalTracks'].toString()),
            _buildStatRow(
              'Общая длительность',
              _formatDuration(overall['totalDuration']),
            ),
            _buildStatRow(
              'Средняя длительность',
              _formatDuration(overall['averageDuration']),
            ),
            _buildStatRow(
              'Общее количество прослушиваний',
              overall['totalPlayCount'].toString(),
            ),
            _buildStatRow(
              'Среднее количество прослушиваний',
              overall['averagePlayCount'].toString(),
            ),
            _buildStatRow(
              'Общее время прослушивания',
              _formatDuration(overall['totalListeningTime']),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteTracksSection(Map<String, dynamic> statistics) {
    final favoriteTracks = statistics['favoriteTracks'] as List<dynamic>;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Любимые треки',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...favoriteTracks.asMap().entries.map((entry) {
              final index = entry.key;
              final track = entry.value as Map<String, dynamic>;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(track['title']),
                subtitle: Text(track['artist']),
                trailing: Text('${track['playCount']} раз'),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistSection(Map<String, dynamic> statistics) {
    final artists = statistics['artists'] as Map<String, dynamic>;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Топ артистов',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...artists.entries.take(10).map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Text('${entry.value} треков'),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreSection(Map<String, dynamic> statistics) {
    final genres = statistics['genres'] as Map<String, dynamic>;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Жанры',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...genres.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Text('${entry.value} треков'),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSection(Map<String, dynamic> statistics) {
    final timeSlots = statistics['timeSlots'] as Map<String, dynamic>;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Время прослушивания',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...timeSlots.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Text('${entry.value} треков'),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '$hoursч $minutesм';
    } else if (minutes > 0) {
      return '$minutesм $remainingSecondsс';
    } else {
      return '$remainingSecondsс';
    }
  }
}
