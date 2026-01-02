import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/services/app_info_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/routes/app_router.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchUrl(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (!context.mounted) {
      return;
    }
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось открыть ссылку')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appInfoService = getIt<AppInfoService>();
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
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.music_note, size: 64),
                    const Gap(16),
                    const Text(
                      'Добро пожаловать в VK Wrapped!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
            ),
            FutureBuilder<String>(
              future: appInfoService.getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Версия ${snapshot.data}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const Gap(8),
            GestureDetector(
              onTap: () => _launchUrl(
                'https://github.com/ChaserVasya/vk-wrapped',
                context,
              ),
              child: const Text(
                'GitHub',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
