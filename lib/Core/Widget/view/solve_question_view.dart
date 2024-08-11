import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constants/app_label.dart';
import '../../Constants/colors.dart';
import '../../Themes/Textstyle/AB_textstyle.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';

class SolveQuestionCard extends StatelessWidget {
  const SolveQuestionCard({
    super.key,
    required this.subject,
    required this.topics,
    required this.youQuestion,
    required this.answerComplexity,
    required this.contentAnswere,
    required this.answerTime,
  });

  final String subject;
  final String topics;
  final String youQuestion;
  final String contentAnswere;
  final int answerComplexity;
  final String answerTime;

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
            //SUBJECT
            LeftTextBold(text: subject),
            const SizedBox(height: 12),
            //TOPICS
            LeftTextBold(text: topics),
            const SizedBox(height: 12),
            //LEVEL
            TextFireClock(
              color: ABColors.secondaryGoldYellow,
              text1: "Level $answerComplexity",
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: "$answerTime Mnt",
            ),
            const SizedBox(height: 28),

            //STEP BY STEP
            MarkdownView(resultText: contentAnswere),
            //BUTTON MORE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  ABTexts.moreExp,
                  style: ABTextstyle.body1Medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
