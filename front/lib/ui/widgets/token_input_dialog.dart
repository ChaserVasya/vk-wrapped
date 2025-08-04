import 'package:flutter/material.dart';
import 'package:front/data/services/token_generator.dart';
import 'package:front/data/services/token_service.dart';
import 'package:front/internal/di/di.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenInputDialog extends StatefulWidget {
  final bool hasToken;

  const TokenInputDialog({super.key, required this.hasToken});

  @override
  State<TokenInputDialog> createState() => _TokenInputDialogState();
}

class _TokenInputDialogState extends State<TokenInputDialog> {
  final _tokenController = TextEditingController();
  final _clientIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentData() async {
    try {
      final tokenService = getIt<TokenService>();
      final currentToken = await tokenService.getToken();
      final currentClientId = await tokenService.getClientId();

      if (currentToken != null) {
        _tokenController.text = currentToken;
      }
      if (currentClientId.isNotEmpty) {
        _clientIdController.text = currentClientId;
      }
    } catch (e) {
      // Игнорируем ошибки загрузки
    }
  }

  Future<void> _saveToken() async {
    if (_tokenController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите токен')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final tokenService = getIt<TokenService>();
      await tokenService.setToken(_tokenController.text.trim());

      if (_clientIdController.text.trim().isNotEmpty) {
        await tokenService.setClientId(_clientIdController.text.trim());
      }

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Токен сохранен')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка сохранения: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _openTokenUrl() async {
    final url = TokenGenerator.generateTokenUrl();
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройка VK токена'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Для получения токена:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('1. Нажмите "Получить токен"'),
            const Text('2. Авторизуйтесь в VK'),
            const Text('3. Скопируйте токен из адресной строки'),
            const Text('4. Вставьте токен в поле ниже'),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _openTokenUrl,
              icon: const Icon(Icons.link),
              label: const Text('Получить токен'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Client ID (необязательно):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _clientIdController,
              decoration: const InputDecoration(
                hintText: '51729127',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              'VK Personal Token:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                hintText: 'v1.1234567890abcdef...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveToken,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Сохранить'),
        ),
      ],
    );
  }
}

/// Показывает диалог для ввода токена
Future<bool?> showTokenInputDialog(
  BuildContext context, {
  bool hasToken = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => TokenInputDialog(hasToken: hasToken),
  );
}
