import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VK Wrapped'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
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
                Navigator.of(context).pushNamed('/statistics');
              },
              icon: const Icon(Icons.analytics),
              label: const Text('Посмотреть статистику'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/detailed-statistics');
              },
              icon: const Icon(Icons.bar_chart),
              label: const Text('Детальная статистика'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const Gap(16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              },
              icon: const Icon(Icons.vpn_key),
              label: const Text('Настроить VK токен'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
