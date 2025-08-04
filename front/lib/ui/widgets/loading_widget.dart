import 'package:flutter/material.dart';

// Переменная для переключения между обычным и тестовым виджетом загрузки
bool useTestLoadingWidget = false;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (useTestLoadingWidget) {
      return const Text('loading');
    }
    return const Center(child: CircularProgressIndicator());
  }
}
