import 'package:flutter/material.dart';

import 'app_text.dart';

class AppButtonWithIcon extends StatelessWidget {
  final String buttonText;

  final VoidCallback onPressed;

  const AppButtonWithIcon({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.map),
      label: AppText(textValue: buttonText, fontSize: 18),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
}
