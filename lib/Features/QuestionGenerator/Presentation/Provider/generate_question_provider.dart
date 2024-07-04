import 'dart:io';

import 'package:apollo_app/Core/Extensions/build_context_dialog_ext.dart';
import 'package:apollo_app/Core/Utilities/Gemini/gemini_utilities.dart';
import 'package:flutter/material.dart';

class GenerateQuestionProvider with ChangeNotifier {
  final genAiService = GeminiUtilites.shared;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _generatedQuestion = "";
  String get generatedQuestion => _generatedQuestion;

  Future<void> generateQuestion(File image, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await genAiService.generateQuestion(image);
      _generatedQuestion = response;
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