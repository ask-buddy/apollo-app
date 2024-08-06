import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {super.key, required this.onPressed, required this.iconColor});

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.gear,
        color: iconColor,
        size: 24,
      ),
      onPressed: onPressed,
    );
  }
}
