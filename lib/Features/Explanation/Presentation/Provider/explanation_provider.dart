import 'dart:io';

import 'package:apollo_app/Core/Extensions/build_context_dialog_ext.dart';
import 'package:apollo_app/Core/Utilities/Gemini/gemini_utilities.dart';
import 'package:flutter/material.dart';

class ExplanationProvider with ChangeNotifier {
  final genAiService = GeminiUtilites.shared;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _explanation = "";
  String get explanation => _explanation;

  Future<void> explainQuestion(File image, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await genAiService.generateExplanation(image);
      _explanation = response;
    } catch (e) {
      if (context.mounted) {
        context.showErrorDialog(
          errorTitle: "ERROR",
          errorMessage: e.toString(),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
