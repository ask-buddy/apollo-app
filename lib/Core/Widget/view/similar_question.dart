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
    required this.youQuestion,
    required this.yourQuestionComplexity,
    required this.youQuestionTime,
    required this.newQuestion,
    required this.newQuestionComplecxity,
    required this.newQuestionTime,
  });
  final String subject;
  final String topics;
  final String youQuestion;
  final int yourQuestionComplexity;
  final String youQuestionTime;
  final String newQuestion;
  final int newQuestionComplecxity;
  final String newQuestionTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ABColors.white.withOpacity(0.04), // Warna background
        borderRadius: BorderRadius.circular(8), // Radius 8
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LeftTextBold(text: subject),
            const SizedBox(height: 12),
            LeftTextBold(text: topics),
            const SizedBox(height: 28),
            const LeftTextBold(text: "Your Questions"),
            const SizedBox(height: 8),
            MarkdownView(resultText: youQuestion),
            const SizedBox(height: 12),
            TextFireClock(
              color: ABColors.errorBrightRed,
              text1: "Level $yourQuestionComplexity",
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: "> $youQuestionTime Mnt",
            ),
            const SizedBox(height: 28),
            const LeftTextBold(text: "New Questions"),
            const SizedBox(height: 8),
            MarkdownView(resultText: newQuestion),
            const SizedBox(height: 12),
            TextFireClock(
              color: ABColors.errorBrightRed,
              text1: "Level $newQuestionComplecxity",
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: "$newQuestionTime Mnt",
            ),
          ],
        ),
      ),
    );
  }
}
