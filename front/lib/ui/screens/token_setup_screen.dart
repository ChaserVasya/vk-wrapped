import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/features/utils/bloc/safe_bloc.dart';
import 'package:front/internal/di/di.dart';
import 'package:front/ui/blocs/token_setup_bloc/token_setup_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenSetupScreen extends StatefulWidget {
  const TokenSetupScreen({super.key});

  @override
  State<TokenSetupScreen> createState() => _TokenSetupScreenState();
}

class _TokenSetupScreenState extends State<TokenSetupScreen> {
  final _tokenController = TextEditingController();
  final _clientIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TokenSetupBloc>().add(const TokenSetupEvent.loadCurrentData());
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  Future<void> _saveToken() async {
    context.read<TokenSetupBloc>().add(
      TokenSetupEvent.saveToken(
        token: _tokenController.text,
        clientId: _clientIdController.text,
      ),
    );
  }

  Future<void> _openTokenUrl() async {
    context.read<TokenSetupBloc>().add(const TokenSetupEvent.openTokenUrl());
  }

  void _updateControllers(TokenSetupState$DataLoaded state) {
    if (state.currentToken != null) {
      _tokenController.text = state.currentToken!;
    }
    if (state.currentClientId.isNotEmpty) {
      _clientIdController.text = state.currentClientId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TokenSetupBloc>(),
      child: EffectListener<TokenSetupBloc, TokenSetupEffect>(
        listener: (context, effect) {
          switch (effect) {
            case TokenSetupEffect$TokenSaved():
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Токен сохранен')));
              Navigator.of(context).pop();
            case TokenSetupEffect$ValidationError(message: final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            case TokenSetupEffect$Error(message: final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            case TokenSetupEffect$OpenUrl(url: final url):
              _launchUrl(url);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Настройка VK токена'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: BlocBuilder<TokenSetupBloc, TokenSetupState>(
            builder: (context, state) {
              // Обновляем контроллеры при загрузке данных
              if (state is TokenSetupState$DataLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _updateControllers(state);
                });
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Инструкция по получению токена:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              '1. Нажмите "Получить токен"',
                              style: TextStyle(fontSize: 14),
                            ),
                            const Text(
                              '2. Авторизуйтесь в VK',
                              style: TextStyle(fontSize: 14),
                            ),
                            const Text(
                              '3. Скопируйте токен из адресной строки',
                              style: TextStyle(fontSize: 14),
                            ),
                            const Text(
                              '4. Вставьте токен в поле ниже',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _openTokenUrl,
                                icon: const Icon(Icons.link),
                                label: const Text('Получить токен'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            const Text(
                              'Client ID (необязательно):',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _clientIdController,
                              decoration: const InputDecoration(
                                hintText: '51729127',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'VK Personal Token:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _tokenController,
                              decoration: const InputDecoration(
                                hintText: 'v1.1234567890abcdef...',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is TokenSetupState$Saving
                                    ? null
                                    : _saveToken,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                child: state is TokenSetupState$Saving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text(
                                        'Сохранить токен',
                                        style: TextStyle(fontSize: 16),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось открыть ссылку: $url')),
        );
      }
    }
  }
}
