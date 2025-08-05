import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/token_setup_bloc/token_setup_bloc.dart';
import 'package:front/ui/widgets/extensions.dart';
import 'package:front/ui/widgets/safe_listeners.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
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
                context.router.pop();
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
  final _tokenRequestUrlController = TextEditingController();
  final _vkAppIdController = TextEditingController();

  @override
  void initState() {
    final state = context.read<TokenSetupBloc>().state;
    _vkAppIdController.text = state.vkAppId;
    super.initState();
  }

  @override
  void dispose() {
    _tokenRequestUrlController.dispose();
    _vkAppIdController.dispose();
    super.dispose();
  }

  Future<void> _saveToken(BuildContext context) async {
    context.read<TokenSetupBloc>().add(
      TokenSetupEvent.vkTokenResponseProvided(_tokenRequestUrlController.text),
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
                          'Ссылка из адресной строки браузера:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        TextField(
                          controller: _tokenRequestUrlController,
                          decoration: InputDecoration(
                            hintText:
                                'https://oauth.vk.com/blank.html#access_token=vk1.a.skY...',
                            border: const OutlineInputBorder(),
                            suffixIcon:
                                _tokenRequestUrlController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () => _saveToken(context),
                                    icon: const Icon(Icons.check),
                                    tooltip: 'Сохранить токен',
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              // Перестраиваем виджет для обновления suffixIcon
                            });
                          },
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
                          const Text(
                            '2. Скопируйте данные из адресной строки в поле выше',
                          ),
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
