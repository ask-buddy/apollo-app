import 'package:flutter/material.dart';

class ReloadButton extends StatelessWidget {
  const ReloadButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.refresh,
        color: Colors.white,
        size: 36,
      ),
      onPressed: onPressed,
    );
  }
}
