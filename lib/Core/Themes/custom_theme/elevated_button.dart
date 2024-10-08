import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

class ABElevatedButtonTheme {
  ///LIGHT THEME
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: ABColors.accent,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: ABColors.accent),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  ///DARK THEME
}
