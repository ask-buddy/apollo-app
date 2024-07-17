// Placeholder file for creating folder
import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Themes/custom_theme/elevated_button.dart';
import 'package:apollo_app/Core/Themes/custom_theme/outlined_button.dart';
import 'package:apollo_app/Core/Themes/custom_theme/text_field_theme.dart';
import 'package:flutter/material.dart';

class ABAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ABColors.primary,
    brightness: Brightness.light,
    elevatedButtonTheme: ABElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: ABOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ABTextFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ABColors.primaryDark,
    brightness: Brightness.dark,
    elevatedButtonTheme: ABElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: ABOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ABTextFieldTheme.darkInputDecorationTheme,
  );
}
