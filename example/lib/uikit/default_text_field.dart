import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String hintText;
  final String? initialText;
  final ValueChanged<String> onChanged;
  const DefaultTextField(
    this.hintText,
    this.onChanged, {
    super.key,
    this.initialText,
  });

  @override
  State<DefaultTextField> createState() => DefaultTextFieldState();
}

class DefaultTextFieldState extends State<DefaultTextField> {
  late final controller = TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String getText() {
    return controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
        ),
        onChanged: (value) => widget.onChanged(value),
      ),
    );
  }
}
