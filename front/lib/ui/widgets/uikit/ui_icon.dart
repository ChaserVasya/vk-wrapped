import 'package:flutter/material.dart';

class UIIcon extends StatelessWidget {
  const UIIcon(this.icon, {super.key, this.color, this.size});

  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: size);
  }
}
