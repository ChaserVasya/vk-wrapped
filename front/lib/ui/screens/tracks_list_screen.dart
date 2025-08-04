import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/domain/exceptions/app_exception.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/features/state_management/states.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/features/utils/bloc/safe_listeners.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/tracks_cubit.dart';
import 'package:gap/gap.dart';

class TracksListScreen extends StatelessWidget {
  const TracksListScreen({super.key});

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
      create: (context) => getIt<TracksCubit>()..init(),
      child: child,
    );
  }
}

class _Listeners extends StatelessWidget {
  const _Listeners({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список треков'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TracksCubit>().init();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<TracksCubit, CommonStates<IList<VkAudioTrack>>>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CommonStates<IList<VkAudioTrack>> state,
  ) {
    switch (state) {
      case CommonStateLoading<IList<VkAudioTrack>>():
        return const LoadingState();
      case CommonStateData<IList<VkAudioTrack>>(data: final tracks):
        return tracks.isEmpty
            ? const EmptyState(text: 'Нет треков для отображения')
            : _buildTracksList(tracks);
      case CommonStateError<IList<VkAudioTrack>>(e: final error):
        return _buildErrorState(
          context,
          error ?? AppException('Неизвестная ошибка'),
        );
    }
  }

  Widget _buildTracksList(IList<VkAudioTrack> tracks) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return _buildTrackCard(track, index + 1);
      },
    );
  }

  Widget _buildTrackCard(VkAudioTrack track, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      Text(
                        track.artist,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const Gap(4),
                Text(
                  _formatDuration(track.duration),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const Spacer(),
                Icon(Icons.music_note, size: 16, color: Colors.grey[600]),
                const Gap(4),
                Text(
                  'ID: ${track.id}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const Gap(4),
                Text(
                  'Owner: ${track.ownerId}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const Spacer(),
                Text(
                  'Full ID: ${track.fullId}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            if (track.url.isNotEmpty) ...[
              const Gap(8),
              Row(
                children: [
                  Icon(Icons.link, size: 16, color: Colors.grey[600]),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      track.url,
                      style: TextStyle(fontSize: 12, color: Colors.blue[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, AppException error) {
    // Проверяем, является ли ошибка NoTokenException
    final isNoTokenError =
        error.toString().toLowerCase().contains('token') ||
        error.toString().toLowerCase().contains('токен');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNoTokenError ? Icons.vpn_key : Icons.error,
              size: 64,
              color: isNoTokenError ? Colors.orange : Colors.red,
            ),
            const Gap(16),
            Text(
              isNoTokenError ? 'Токен не настроен' : 'Ошибка загрузки',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              isNoTokenError
                  ? 'Для просмотра треков необходимо настроить VK токен'
                  : error.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            if (isNoTokenError) ...[
              ElevatedButton.icon(
                onPressed: () async {
                  // Переходим в настройки
                  await Navigator.of(context).pushNamed('/settings');
                  // После возвращения делаем ещё одну попытку
                  if (context.mounted) {
                    context.read<TracksCubit>().init();
                  }
                },
                icon: const Icon(Icons.settings),
                label: const Text('Настроить токен'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: () {
                  context.read<TracksCubit>().init();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Повторить'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
