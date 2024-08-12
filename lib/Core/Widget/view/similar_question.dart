import 'package:apollo_app/Core/Utilities/Helper/get_color_by_level.dart';
import 'package:apollo_app/Features/Chat/Model/similar_question.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/colors.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';

class SimilarQuestionCard extends StatelessWidget {
  const SimilarQuestionCard({
    super.key,
    required this.similarQuestion,
  });
  final SimilarQuestion similarQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ABColors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SUBJECT
            LeftTextBold(text: similarQuestion.subject!),
            const SizedBox(height: 12),

            //TPOICS
            LeftTextBold(text: similarQuestion.topics!),
            const SizedBox(height: 24),

            //YOUR QUESTION
            MarkdownView(
                resultText: similarQuestion.yourQuestion!.originalProblem!),
            TextFireClock(
              color: getDifficultyColor(
                  similarQuestion.yourQuestion!.estimatedDifficulty!),
              text1: similarQuestion.yourQuestion!.estimatedDifficulty!,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: similarQuestion.yourQuestion!.estimatedTime!,
            ),
            const SizedBox(height: 24),

            //NEW QUESTION
            MarkdownView(
                resultText: similarQuestion.newQuestion!.generatedProblem!),
            TextFireClock(
              color: getDifficultyColor(
                  similarQuestion.newQuestion!.estimatedDifficulty!),
              text1: similarQuestion.newQuestion!.estimatedDifficulty!,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: similarQuestion.newQuestion!.estimatedTime!,
            ),
          ],
        ),
      ),
    );
  }
}
