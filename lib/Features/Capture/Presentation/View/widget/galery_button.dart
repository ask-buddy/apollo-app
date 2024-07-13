import 'package:flutter/material.dart';

class GaleryButton extends StatelessWidget {
  const GaleryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.image,
        color: Colors.white,
        size: 36,
      ),
      onPressed: onPressed,
    );
  }
}
