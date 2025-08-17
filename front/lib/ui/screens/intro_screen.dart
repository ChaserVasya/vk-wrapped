import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/services/first_launch_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/resources/gen/assets.gen.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _isImageFocused = false;

  AssetGenImage get _todayMeme {
    final today = DateTime.now();
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
    final memeIndex = dayOfYear % Assets.memes.values.length;
    return Assets.memes.values[memeIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(60),
            _buildIntroImage(),
            const Gap(24),
            _buildMemeSection(),
            const Gap(24),
            _buildTodayEmodgi(),
            const Gap(32),
            _buildCallToAction(),
            const Gap(40),
            _buildNavigationButton(context),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroImage() {
    return Container(
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
        child: Assets.intro.intro1.image(
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
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
                      'intro image error',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMemeSection() {
    return Column(
      children: [
        Text(
          'Мем дня',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(16),
        GestureDetector(
          onTap: () {
            setState(() {
              _isImageFocused = !_isImageFocused;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: _isImageFocused ? _buildClearImage() : _buildShimmerImage(),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _todayMeme.image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
        ),
      ),
    );
  }

  Widget _buildClearImage() {
    return Container(
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
        child: _todayMeme.image(
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCallToAction() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: const Column(
        children: [
          Text(
            'Ставьте лайки, звёздочки. Пишите пожелания.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.thumb_up, color: Colors.blue, size: 20),
              Gap(4),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Gap(4),
              Icon(Icons.favorite, color: Colors.red, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        // Отмечаем что приложение уже запускалось
        final firstLaunchService = getIt<FirstLaunchService>();
        await firstLaunchService.markAsLaunched();

        // Переходим на главную страницу
        if (mounted) {
          // ignore: use_build_context_synchronously
          await context.router.replaceAll([const HomeRoute()]);
        }
      },
      icon: const Icon(Icons.home),
      label: const Text('На главную'),
    );
  }

  Widget _buildTodayEmodgi() {
    return const Column(
      children: [
        Text(
          'Эмоджи дня',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          '\u{1F62D}',
          style: TextStyle(
            fontSize: 48,
            fontFamilyFallback: ['Noto Color Emoji', 'Apple Color Emoji'],
          ),
        ),
      ],
    );
  }
}
