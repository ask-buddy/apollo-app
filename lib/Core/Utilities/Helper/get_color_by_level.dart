import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

Color getDifficultyColor(String difficultyLevel) {
  int level =
      int.tryParse(difficultyLevel.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  switch (level) {
    case 1:
      return ABColors.primaryBlue;
    case 2:
      return ABColors.accentLight;
    case 3:
      return ABColors.secondaryLight;
    case 4:
      return ABColors.secondaryGoldYellow;
    case 5:
      return ABColors.errorBrightRed;
    default:
      return Colors.white;
  }
}
