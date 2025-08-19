import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/domain/entities/meme_response.dart';
import 'package:front/features/state_management/common_states.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/meme_cubit.dart';
import 'package:front/ui/widgets/error_state.dart';
import 'package:front/ui/widgets/loading_state.dart';
import 'package:gap/gap.dart';

class MemeWidget extends StatelessWidget {
  const MemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemeCubit>()..loadMeme(),
      child: BlocBuilder<MemeCubit, CommonStates<MemeResponse>>(
        builder: (context, state) {
          return switch (state) {
            CommonStateLoading() => const LoadingStateWidget(),
            CommonStateError(e: final error) => ErrorStateWidget(
              error,
              onRefresh: () => context.read<MemeCubit>().loadMeme(),
            ),
            CommonStateData(data: final meme) => _MemeContent(meme: meme),
          };
        },
      ),
    );
  }
}

class _MemeContent extends StatelessWidget {
  final MemeResponse meme;

  const _MemeContent({required this.meme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Мем изображение
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              meme.url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image, size: 64, color: Colors.grey),
                        const Gap(8),
                        Text(
                          'Мем дня',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Gap(16),
        // Кнопка лайка
        GestureDetector(
          onTap: () {
            context.read<MemeCubit>().toggleLike();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: meme.isLiked ? Colors.red[50] : Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: meme.isLiked ? Colors.red[200]! : Colors.grey[300]!,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  meme.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: meme.isLiked ? Colors.red : Colors.grey[600],
                  size: 20,
                ),
                const Gap(8),
                Text(
                  meme.isLiked ? 'Лайкнуто' : 'Лайкнуть',
                  style: TextStyle(
                    color: meme.isLiked ? Colors.red[700] : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
