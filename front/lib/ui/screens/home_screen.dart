import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:gap/gap.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return child;
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
        title: const Text('VK Wrapped'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.music_note, size: 64),
            const Gap(16),
            const Text(
              'Добро пожаловать в VK Wrapped!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            const Text(
              'Анализируем вашу музыкальную историю',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            ElevatedButton.icon(
              onPressed: () {
                context.router.push(const StatisticsRoute());
              },
              icon: const Icon(Icons.analytics),
              label: const Text('Посмотреть статистику'),
            ),
            const Gap(16),
            ElevatedButton.icon(
              onPressed: () {
                context.router.push(const ListenedRoute());
              },
              icon: const Icon(Icons.music_note),
              label: const Text('Прослушанное'),
            ),

            const Gap(16),
            ElevatedButton.icon(
              onPressed: () {
                context.router.push(const SettingsRoute());
              },
              icon: const Icon(Icons.vpn_key),
              label: const Text('Настроить VK токен'),
            ),
            const Gap(16),
            ElevatedButton.icon(
              onPressed: () {
                context.router.push(const IntroRoute());
              },
              icon: const Icon(Icons.celebration),
              label: const Text('Intro'),
            ),
          ],
        ),
      ),
    );
  }
}
