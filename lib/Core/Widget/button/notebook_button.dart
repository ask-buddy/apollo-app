import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotebookButton extends StatelessWidget {
  const NotebookButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const FaIcon(
        FontAwesomeIcons.book,
        color: Colors.white,
        size: 24,
      ),
      onPressed: onPressed,
    );
  }
}
