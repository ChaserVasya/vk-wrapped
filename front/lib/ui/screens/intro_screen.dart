import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/services/first_launch_service.dart';
import 'package:front/domain/services/remote_config_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:front/ui/widgets/meme_widget.dart';
import 'package:gap/gap.dart';

@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final RemoteConfigService _remoteConfigService;

  @override
  void initState() {
    super.initState();
    _remoteConfigService = getIt<RemoteConfigService>();
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

  Widget _buildMemeSection() {
    return Column(
      children: [
        Text(
          'Мем дня',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(16),
        MemeWidget(),
      ],
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
    return Column(
      children: [
        const Text(
          'Эмоджи дня',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        StreamBuilder<String>(
          stream: _remoteConfigService.introEmojiStream,
          builder: (context, snapshot) {
            final emoji = snapshot.data ?? _remoteConfigService.introEmoji;

            if (emoji.isEmpty) {
              return const Column(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(),
                  ),
                  Gap(8),
                  Text(
                    'Загрузка эмоджи...',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              );
            }

            return Column(
              children: [Text(emoji, style: const TextStyle(fontSize: 48))],
            );
          },
        ),
      ],
    );
  }
}
