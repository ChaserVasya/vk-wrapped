import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/features/utils/bloc/safe_listeners.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/token_setup_bloc/token_setup_bloc.dart';
import 'package:front/ui/widgets/extensions.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenSetupScreen extends StatelessWidget {
  const TokenSetupScreen({super.key});

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
      create: (context) => getIt<TokenSetupBloc>(),
      child: child,
    );
  }
}

class _Listeners extends StatelessWidget {
  const _Listeners({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ShowErrorSafeListener<TokenSetupBloc>(),
        EffectListener<TokenSetupBloc, TokenSetupEffect>(
          listener: (context, effect) {
            switch (effect) {
              case TokenSetupEffect$Finish():
                context.showSnackBar('Токен сохранен');
                Navigator.of(context).pop();
            }
          },
        ),
      ],
      child: child,
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _tokenController = TextEditingController();
  final _vkAppIdController = TextEditingController();

  @override
  void initState() {
    final state = context.read<TokenSetupBloc>().state;
    _tokenController.text = state.currentToken ?? '';
    _vkAppIdController.text = state.vkAppId;
    super.initState();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _vkAppIdController.dispose();
    super.dispose();
  }

  Future<void> _saveToken(BuildContext context) async {
    context.read<TokenSetupBloc>().add(
      TokenSetupEvent.vkTokenResponseProvided(_tokenController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройка VK токена')),
      body: BlocBuilder<TokenSetupBloc, TokenSetupState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Настройки токена:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(16),
                        const Text(
                          'Vk App Id:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        TextField(
                          controller: _vkAppIdController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onEditingComplete: () {
                            context.read<TokenSetupBloc>().add(
                              TokenSetupEvent.vkAppIdSaved(
                                _vkAppIdController.text,
                              ),
                            );
                          },
                        ),
                        const Gap(16),
                        const Text(
                          'VK Personal Token:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        TextField(
                          controller: _tokenController,
                          decoration: const InputDecoration(
                            hintText: 'v1.1234567890abcdef...',
                            border: OutlineInputBorder(),
                          ),
                          onEditingComplete: () => _saveToken(context),
                        ),
                        const Gap(16),
                      ],
                    ),
                  ),
                ),
                if (state.tokenGenerationUrl != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Инструкция по получению токена:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(16),
                          const Text(
                            '1. Нажмите "Получить токен" и все последующие кнопочки в браузере пока не появится текст "Пожалуйста, не копируйте данные из адресной строки ..."',
                          ),
                          const Text('2. Скопируйте данные из адресной строки'),
                          const Text('3. Вставьте их в поле ниже'),
                          const Gap(16),
                          SizedBox(
                            child: ElevatedButton.icon(
                              onPressed: () => _launchUrl(
                                state.tokenGenerationUrl!,
                                context,
                              ),
                              icon: const Icon(Icons.link),
                              label: const Text('Получить токен'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ].separateBy(const Gap(16)),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    print('VK TOKEN URL: $url');
    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (!context.mounted) {
      return;
    }
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      context.showSnackBar(
        'Запрещено открывать ссылки( Что-то не так с разрешениями',
      );
    }
  }
}
