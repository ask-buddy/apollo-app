import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  const FlashButton(
      {super.key, required this.isFlashOn, required this.onPressed});

  final bool isFlashOn;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFlashOn ? Icons.flash_on : Icons.flash_off,
        color: Colors.white,
        size: 36,
      ),
      onPressed: onPressed,
    );
  }
}
