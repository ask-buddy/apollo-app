import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.settings,
        color: Colors.white,
        size: 36,
      ),
      onPressed: onPressed,
    );
  }
}
