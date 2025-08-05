import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/albums_with_artists_cubit.dart';
import 'package:front/ui/widgets/album_card.dart';
import 'package:front/ui/widgets/common_state_handler.dart';
import 'package:gap/gap.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

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
      create: (context) => getIt<AlbumsWithArtistsCubit>()..init(),
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
    return CommonStateHandler<
      CommonStates<IList<(VkAlbum, IList<String>, int)>>,
      IList<(VkAlbum, IList<String>, int)>
    >(
      selector: (context) => context.watch<AlbumsWithArtistsCubit>().state,
      dataBuilder: (context, albumsWithCount) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Альбомы',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Gap(8),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: albumsWithCount.length,
                  itemBuilder: (context, index) {
                    final (album, artists, trackCount) = albumsWithCount[index];
                    return AlbumCard(
                      album: album,
                      trackCount: trackCount,
                      artists: artists,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      onRefreshRequested: () => context.read<AlbumsWithArtistsCubit>().init(),
    );
  }
}
