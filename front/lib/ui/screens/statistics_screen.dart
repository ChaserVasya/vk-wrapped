import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/services/statistics_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_event.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_state.dart';
import 'package:front/ui/widgets/audio_track_card.dart';
import 'package:front/ui/widgets/common_state_handler.dart';
import 'package:front/ui/widgets/safe_listeners.dart';
import 'package:intl/intl.dart';

@RoutePage()
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StatisticsBloc>()..add(const StatisticsEvent.loadStatistics()),
      child: const StatisticsView(),
    );
  }
}

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [ShowErrorSafeListener<StatisticsBloc>()],
      child: Scaffold(
        appBar: AppBar(title: const Text('VK Wrapped')),
        body: CommonStateHandler<StatisticsState, StatisticStateData>(
          selector: (context) => context.watch<StatisticsBloc>().state,
          dataBuilder: (context, data) => StatisticsCarousel(data: data),
          onRefreshRequested: () => context.read<StatisticsBloc>().add(
            const StatisticsEvent.loadStatistics(),
          ),
        ),
      ),
    );
  }
}

class StatisticsCarousel extends StatefulWidget {
  final StatisticStateData data;

  const StatisticsCarousel({super.key, required this.data});

  @override
  State<StatisticsCarousel> createState() => _StatisticsCarouselState();
}

class _StatisticsCarouselState extends State<StatisticsCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _OverviewPage(data: widget.data),
              _TopArtistsPage(data: widget.data),
              _TopTracksPage(data: widget.data),
              _TracksWithSameTitlePage(data: widget.data),
              _MonthStatsPage(data: widget.data),
              _ExtremesPage(data: widget.data),
            ],
          ),
        ),
        _PageIndicator(currentPage: _currentPage, totalPages: 6),
      ],
    );
  }
}

class _OverviewPage extends StatelessWidget {
  final StatisticStateData data;

  const _OverviewPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Обзор года',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          _StatCard(
            title: 'Общее время прослушивания',
            value: _formatDuration(data.totalListeningTime),
            icon: Icons.music_note,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Количество прослушиваний',
            value: '${data.totalPlayCount}',
            icon: Icons.play_circle,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Уникальных треков',
            value: '${data.uniqueTracksCount}',
            icon: Icons.queue_music,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Уникальных исполнителей',
            value: '${data.uniqueArtistsCount}',
            icon: Icons.person,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Уникальных альбомов',
            value: '${data.uniqueAlbumsCount}',
            icon: Icons.album,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Уникальных жанров',
            value: '${data.uniqueGenresCount}',
            icon: Icons.category,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Средняя продолжительность трека',
            value: _formatDuration(data.averageTrackDuration),
            icon: Icons.timer,
          ),
          const SizedBox(height: 16),
          _StatCard(
            title: 'Удалённых треков',
            value: '${data.unavailableTracksCount}',
            icon: Icons.error_outline,
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hoursч $minutesм';
    }
    return '$minutesм';
  }
}

class _TopArtistsPage extends StatelessWidget {
  final StatisticStateData data;

  const _TopArtistsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Топ исполнителей',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.topArtistsWithPhotos.length,
              itemBuilder: (context, index) {
                final artistWithStats = data.topArtistsWithPhotos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[300],
                      child: artistWithStats.artist.photo != null
                          ? ClipOval(
                              child: Image.network(
                                artistWithStats.artist.photo!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildFallbackAvatar(index + 1);
                                },
                              ),
                            )
                          : _buildFallbackAvatar(index + 1),
                    ),
                    title: Text(
                      artistWithStats.artist.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${artistWithStats.playCount} прослушиваний',
                    ),
                    trailing: Text(
                      _formatDuration(
                        Duration(seconds: artistWithStats.totalDuration),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar(int number) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hoursч $minutesм';
    }
    return '$minutesм';
  }
}

class _TopTracksPage extends StatelessWidget {
  final StatisticStateData data;

  const _TopTracksPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Топ треков',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.topTracks.length,
              itemBuilder: (context, index) {
                final trackWithStats = data.topTracks[index];
                return AudioTrackCard(
                  track: trackWithStats.track,
                  playCount: trackWithStats.playCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TracksWithSameTitlePage extends StatelessWidget {
  final StatisticStateData data;

  const _TracksWithSameTitlePage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Топ треков с одинаковым названием',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.tracksWithSameTitle.length,
              itemBuilder: (context, index) {
                final trackStat = data.tracksWithSameTitle[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      trackStat.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${trackStat.trackCount} версий'),
                    trailing: Text(
                      _formatDuration(
                        Duration(seconds: trackStat.totalDuration),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hoursч $minutesм';
    }
    return '$minutesм';
  }
}

class _MonthStatsPage extends StatelessWidget {
  final StatisticStateData data;

  const _MonthStatsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    // Группируем статистику по годам
    final statsByYear = <int, List<MonthStats>>{};
    for (final monthStat in data.monthStats) {
      statsByYear.putIfAbsent(monthStat.year, () => []).add(monthStat);
    }

    // Сортируем годы по возрастанию
    final sortedYears = statsByYear.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'По месяцам',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: sortedYears.length,
              itemBuilder: (context, yearIndex) {
                final year = sortedYears[yearIndex];
                final yearStats = statsByYear[year]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок года
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 8.0,
                      ),
                      child: Text(
                        '$year',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    // Статистика по месяцам для этого года
                    ...yearStats.map((monthStat) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                          ),
                          title: Text(
                            monthStat.monthLabel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${monthStat.playCount} прослушиваний',
                          ),
                          trailing: Text(
                            '${((monthStat.playCount / data.totalPlayCount) * 100).toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                    // Добавляем отступ между годами (кроме последнего)
                    if (yearIndex < sortedYears.length - 1)
                      const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ExtremesPage extends StatelessWidget {
  final StatisticStateData data;

  const _ExtremesPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Рекорды',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          if (data.longestTrack != null)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Самый длинный трек',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AudioTrackCard(track: data.longestTrack!),
                  ],
                ),
              ),
            ),
          if (data.shortestTrack != null)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer_off,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Самый короткий трек',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AudioTrackCard(track: data.shortestTrack!),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          if (data.mostActiveDay != null)
            _StatCard(
              title: 'Самый активный день',
              value: _formatMostActiveDay(data.mostActiveDay!),
              icon: Icons.event,
            ),
        ],
      ),
    );
  }

  String _formatMostActiveDay(MostActiveDayStats day) {
    final duration = Duration(seconds: day.totalDuration);
    return '${DateFormat('dd.MM.yyyy').format(day.date)}\n${day.playCount} прослушиваний, ${_formatDuration(duration)}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hoursч $minutesм';
    }
    return '$minutesм';
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PageIndicator({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
