import 'package:apollo_app/Core/Utilities/Helper/get_color_by_level.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/colors.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';

class SimilarQuestionCard extends StatelessWidget {
  const SimilarQuestionCard({
    super.key,
    required this.subject,
    required this.topics,
    required this.yourOriginalProblem,
    required this.yourEstimatedDifficulty,
    required this.yourEstimatedTime,
    required this.newOriginalProblem,
    required this.newEstimatedDifficulty,
    required this.newEstimatedTime,
  });
  final String subject;
  final String topics;
  final String yourOriginalProblem;
  final String yourEstimatedDifficulty;
  final String yourEstimatedTime;
  final String newOriginalProblem;
  final String newEstimatedDifficulty;
  final String newEstimatedTime;

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
            LeftTextBold(text: subject),
            const SizedBox(height: 12),

            //TPOICS
            LeftTextBold(text: topics),
            const SizedBox(height: 24),

            //YOUR QUESTION
            MarkdownView(resultText: yourOriginalProblem),
            TextFireClock(
              color: getDifficultyColor(yourEstimatedDifficulty),
              text1: yourEstimatedDifficulty,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: "$yourEstimatedTime Mnt",
            ),
            const SizedBox(height: 24),

            //NEW QUESTION
            MarkdownView(resultText: newOriginalProblem),
            TextFireClock(
              color: getDifficultyColor(yourEstimatedDifficulty),
              text1: newEstimatedDifficulty,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: newEstimatedTime,
            ),
          ],
        ),
      ),
    );
  }
}
