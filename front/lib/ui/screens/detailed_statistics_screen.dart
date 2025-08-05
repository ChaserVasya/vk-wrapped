import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/state_management/states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/features/utils/bloc/safe_listeners.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/detailed_statistics_bloc/detailed_statistics_bloc.dart';
import 'package:front/ui/widgets/extensions.dart';
import 'package:gap/gap.dart';

class DetailedStatisticsScreen extends StatelessWidget {
  const DetailedStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Providers(child: _Listeners(child: _View()));
  }
}

class _Providers extends StatelessWidget {
  const _Providers({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DetailedStatisticsBloc>()
            ..add(const DetailedStatisticsEvent.init()),
      child: child,
    );
  }
}

class _Listeners extends StatelessWidget {
  const _Listeners({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ShowErrorSafeListener<DetailedStatisticsBloc>(),
        EffectListener<DetailedStatisticsBloc, DetailedStatisticsEffect>(
          listener: (context, effect) {
            switch (effect) {
              case DetailedStatisticsEffect$Error(message: final message):
                context.showSnackBar('Ошибка: $message');
            }
          },
        ),
      ],
      child: child,
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детальная статистика'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<DetailedStatisticsBloc>().add(
                const DetailedStatisticsEvent.init(),
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
              const DetailedStatisticsEvent.init(),
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
              const Gap(24),
              _buildFavoriteTracksSection(statistics),
              const Gap(24),
              _buildArtistSection(statistics),
              const Gap(24),
              _buildGenreSection(statistics),
              const Gap(24),
              _buildTimeSection(statistics),
            ],
          ),
        );
      default:
        return const EmptyState(text: 'Статистика не найдена');
    }
  }

  Widget _buildOverallSection(IMap<String, dynamic> statistics) {
    final overall = statistics['overall'] as IMap<String, dynamic>;

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
            const Gap(16),
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

  Widget _buildFavoriteTracksSection(IMap<String, dynamic> statistics) {
    final favoriteTracks = statistics['favoriteTracks'] as IList<dynamic>;

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
            const Gap(16),
            ...favoriteTracks.asMap().entries.map((entry) {
              final index = entry.key;
              final track = entry.value as IMap<String, dynamic>;
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

  Widget _buildArtistSection(IMap<String, dynamic> statistics) {
    final artists = statistics['artists'] as IMap<String, dynamic>;

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
            const Gap(16),
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

  Widget _buildGenreSection(IMap<String, dynamic> statistics) {
    final genres = statistics['genres'] as IMap<String, dynamic>;

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
            const Gap(16),
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

  Widget _buildTimeSection(IMap<String, dynamic> statistics) {
    final timeSlots = statistics['timeSlots'] as IMap<String, dynamic>;

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
            const Gap(16),
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
