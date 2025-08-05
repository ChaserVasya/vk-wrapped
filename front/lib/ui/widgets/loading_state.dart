import 'package:flutter/material.dart';
import 'package:front/ui/widgets/loading_widget.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [LoadingWidget(), SizedBox(height: 16), Text('Загрузка...')],
      ),
    );
  }
}
