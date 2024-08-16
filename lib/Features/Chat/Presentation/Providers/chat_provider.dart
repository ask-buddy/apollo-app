import 'dart:io';

import 'package:apollo_app/Core/Extensions/build_context_dialog_ext.dart';
import 'package:apollo_app/Core/Utilities/Gemini/gemini_utilities.dart';
import 'package:apollo_app/Features/Chat/Presentation/Enum/prompt_enum.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final genAiService = GeminiUtilites.shared;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PromptEnum _prompt = PromptEnum.normalPrompt;
  PromptEnum get promptState => _prompt;

  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'ai',
      'text': 'Hello! How can I assist you today?',
      'prompt': 'normalPrompt'
    }
  ];

  List<Map<String, dynamic>> get messages => _messages;

  void changePrompt(PromptEnum newPromptState) {
    _prompt = newPromptState;
    notifyListeners();
  }

  Future<void> doPrompt(
      String? question, BuildContext context, File? image) async {
    _isLoading = true;
    notifyListeners();
    String response = "No Response Provided";
    print("PROMPT HERE: ${_prompt.toString()}");
    try {
      switch (_prompt) {
        case PromptEnum.normalPrompt:
          print("Normal");
          if (question != null) {
            response = await genAiService.askPrompt(question);
          }
        case PromptEnum.generateSimiliarQuestion:
          print("Generate Similiar Question");
          if (image != null) {
            response = await genAiService.generateQuestion(image);
          }
        case PromptEnum.solveNewQuestion:
          print("Solve New Question");
          if (image != null) {
            response = await genAiService.solveQuestionWithImage(image);
          }

        case PromptEnum.checkAnswer:
          print("Check Answer");
          if (image != null) {
            response = await genAiService.solveQuestionWithImage(image);
          }
        case PromptEnum.actExamInfo:
          print("ACT EXAM INFO");
          return;
      }
      _messages.add({
        'sender': 'ai',
        'text': response,
        'prompt': PromptEnumHelper.toAbsoluteString(_prompt)
      });
      print("ANSWER HERE: $response");
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

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }

  Future<void> appendMessages(String message, BuildContext context) async {
    _messages.add({'sender': 'user', 'text': message, 'prompt': "normalText"});
    notifyListeners();
  }
}
