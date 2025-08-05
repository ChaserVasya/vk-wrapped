import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/tracks_cubit.dart';
import 'package:front/ui/widgets/common_state_handler.dart';
import 'package:front/ui/widgets/empty_state.dart';
import 'package:front/ui/widgets/safe_listeners.dart';
import 'package:front/ui/widgets/track_card.dart';

@RoutePage()
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
      body:
          CubitStateHandler<
            TracksCubit,
            CommonStates<IList<VkAudioTrack>>,
            IList<VkAudioTrack>
          >(
            dataBuilder: (context, tracks) {
              return tracks.isEmpty
                  ? const EmptyStateWidget(text: 'Нет треков для отображения')
                  : _buildTracksList(tracks);
            },
            onRefreshRequested: () => context.read<TracksCubit>().init(),
          ),
    );
  }

  Widget _buildTracksList(IList<VkAudioTrack> tracks) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return TrackCard(track: track, index: index + 1);
      },
    );
  }
}
