import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/remote/api/vk_api_client.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/albums_cubit.dart';
import 'package:front/ui/widgets/album_card.dart';
import 'package:front/ui/widgets/common_state_handler.dart';
import 'package:front/ui/widgets/empty_state.dart';

@RoutePage()
class AlbumsListScreen extends StatelessWidget {
  const AlbumsListScreen({super.key});

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
      create: (context) => getIt<AlbumsCubit>()..init(),
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
        title: const Text('Альбомы'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AlbumsCubit>().init();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body:
          CubitStateHandler<
            AlbumsCubit,
            CommonStates<IList<VkAlbum>>,
            IList<VkAlbum>
          >(
            dataBuilder: (context, albums) {
              return albums.isEmpty
                  ? const EmptyStateWidget(text: 'Нет альбомов для отображения')
                  : _buildAlbumsGrid(albums);
            },
            onRefreshRequested: () => context.read<AlbumsCubit>().init(),
          ),
    );
  }

  Widget _buildAlbumsGrid(IList<VkAlbum> albums) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return AlbumCard(
          album: album,
          onTap: () {
            // TODO: Добавить навигацию к трекам альбома
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Альбом: ${album.title}')));
          },
        );
      },
    );
  }
}
