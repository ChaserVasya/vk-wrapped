import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_listeners.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_event.dart';
import 'package:front/ui/blocs/statistics_bloc/statistics_state.dart';
import 'package:front/ui/widgets/loading_state.dart';

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
        appBar: AppBar(
          title: const Text('VK Wrapped 2024'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            return switch (state) {
              StatisticsState$LoadingState() => const LoadingStateWidget(),
              StatisticsState$DataState() => StatisticsCarousel(data: state),
              _ => const LoadingStateWidget(),
            };
          },
        ),
      ),
    );
  }
}

class StatisticsCarousel extends StatefulWidget {
  final StatisticsState$DataState data;

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
              _TimeStatsPage(data: widget.data),
              _DayStatsPage(data: widget.data),
              _MonthStatsPage(data: widget.data),
              _ExtremesPage(data: widget.data),
            ],
          ),
        ),
        _PageIndicator(currentPage: _currentPage, totalPages: 7),
      ],
    );
  }
}

class _OverviewPage extends StatelessWidget {
  final StatisticsState$DataState data;

  const _OverviewPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Обзор года',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
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
            title: 'Средняя продолжительность трека',
            value: _formatDuration(data.averageTrackDuration),
            icon: Icons.timer,
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
  final StatisticsState$DataState data;

  const _TopArtistsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Топ исполнителей',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.topArtists.length,
              itemBuilder: (context, index) {
                final artist = data.topArtists[index];
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
                      artist.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${artist.playCount} прослушиваний'),
                    trailing: Text(
                      _formatDuration(Duration(seconds: artist.totalDuration)),
                      style: const TextStyle(
                        color: Colors.blue,
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

class _TopTracksPage extends StatelessWidget {
  final StatisticsState$DataState data;

  const _TopTracksPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Топ треков',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.topTracks.length,
              itemBuilder: (context, index) {
                final track = data.topTracks[index];
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
                      track.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${track.artist} • ${track.playCount} раз'),
                    trailing: Text(
                      _formatDuration(Duration(seconds: track.duration)),
                      style: const TextStyle(
                        color: Colors.blue,
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
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _TimeStatsPage extends StatelessWidget {
  final StatisticsState$DataState data;

  const _TimeStatsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Время суток',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.timeOfDayStats.length,
              itemBuilder: (context, index) {
                final timeStat = data.timeOfDayStats[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.blue),
                    title: Text(
                      timeStat.hourLabel,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${timeStat.playCount} прослушиваний'),
                    trailing: Text(
                      '${((timeStat.playCount / data.totalPlayCount) * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        color: Colors.blue,
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
}

class _DayStatsPage extends StatelessWidget {
  final StatisticsState$DataState data;

  const _DayStatsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Дни недели',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.dayOfWeekStats.length,
              itemBuilder: (context, index) {
                final dayStat = data.dayOfWeekStats[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    title: Text(
                      dayStat.dayLabel,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${dayStat.playCount} прослушиваний'),
                    trailing: Text(
                      '${((dayStat.playCount / data.totalPlayCount) * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        color: Colors.blue,
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
}

class _MonthStatsPage extends StatelessWidget {
  final StatisticsState$DataState data;

  const _MonthStatsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'По месяцам',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: data.monthStats.length,
              itemBuilder: (context, index) {
                final monthStat = data.monthStats[index];
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
                    subtitle: Text('${monthStat.playCount} прослушиваний'),
                    trailing: Text(
                      '${((monthStat.playCount / data.totalPlayCount) * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        color: Colors.blue,
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
}

class _ExtremesPage extends StatelessWidget {
  final StatisticsState$DataState data;

  const _ExtremesPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Рекорды',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          if (data.longestTrack != null)
            _StatCard(
              title: 'Самый длинный трек',
              value:
                  '${data.longestTrack!.title}\n${data.longestTrack!.artist}',
              icon: Icons.timer,
            ),
          const SizedBox(height: 16),
          if (data.shortestTrack != null)
            _StatCard(
              title: 'Самый короткий трек',
              value:
                  '${data.shortestTrack!.title}\n${data.shortestTrack!.artist}',
              icon: Icons.timer_off,
            ),
          const SizedBox(height: 16),
          if (data.mostActiveDay != null)
            _StatCard(
              title: 'Самый активный день',
              value: _formatDate(data.mostActiveDay!),
              icon: Icons.event,
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
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
              color: currentPage == index ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
