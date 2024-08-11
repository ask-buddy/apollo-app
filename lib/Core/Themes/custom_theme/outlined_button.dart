import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

class ABOutlinedButtonTheme {
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ABColors.white,
      side: const BorderSide(color: ABColors.concrete),
      textStyle: const TextStyle(
          fontSize: 16, color: ABColors.white, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
