import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/artists_cubit.dart';
import 'package:front/ui/widgets/artist_card.dart';
import 'package:front/ui/widgets/common_state_handler.dart';
import 'package:gap/gap.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

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
      create: (context) => getIt<ArtistsCubit>()..init(),
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
    return CommonStateHandler<CommonStates<IList<String>>, IList<String>>(
      selector: (context) => context.watch<ArtistsCubit>().state,
      dataBuilder: (context, artists) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Артисты',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Gap(16),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    final artist = artists[index];
                    return ArtistCard(artist: artist, playCount: index + 1);
                  },
                ),
              ),
            ],
          ),
        );
      },
      onRefreshRequested: () => context.read<ArtistsCubit>().init(),
    );
  }
}
