import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constants/app_label.dart';
import '../../Constants/colors.dart';
import '../../Themes/Textstyle/AB_textstyle.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';

class SolveQuestionCard extends StatefulWidget {
  const SolveQuestionCard({
    super.key,
    required this.subject,
    required this.topics,
    required this.yourEstimatedDifficulty,
    required this.yourEstimatedTime,
    required this.solutionSteps,
    required this.detailedExplanation,
  });

  final String subject;
  final String topics;
  final String yourEstimatedDifficulty;
  final String yourEstimatedTime;
  final String solutionSteps;
  final String detailedExplanation;

  @override
  _SolveQuestionCardState createState() => _SolveQuestionCardState();
}

class _SolveQuestionCardState extends State<SolveQuestionCard> {
  bool isExpanded = false;

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
            //SUBJECT
            LeftTextBold(text: widget.subject),
            const SizedBox(height: 12),

            //TOPICS
            LeftTextBold(text: widget.topics),
            const SizedBox(height: 12),

            //LEVEL
            TextFireClock(
              color: ABColors.secondaryGoldYellow,
              text1: widget.yourEstimatedDifficulty,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: widget.yourEstimatedTime,
            ),
            const SizedBox(height: 28),

            //STEP
            MarkdownView(resultText: widget.solutionSteps),
            //DETAIL EXPLANATION
            if (isExpanded)
              MarkdownView(resultText: widget.detailedExplanation),
            //BUTTON MORE
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Hide Explanation' : ABTexts.moreExp,
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
