import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashButton extends StatelessWidget {
  const FlashButton(
      {super.key, required this.isFlashOn, required this.onPressed});

  final bool isFlashOn;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.bolt,
        color: isFlashOn ? ABColors.secondaryGoldYellow : ABColors.white,
        size: 24,
      ),
      onPressed: onPressed,
    );
  }
}
