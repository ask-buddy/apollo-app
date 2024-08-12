import 'package:apollo_app/Features/Chat/Model/check_answer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constants/colors.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';

class CheckAnswereCard extends StatefulWidget {
  const CheckAnswereCard({
    super.key,
    required this.checkAnswer,
  });
  final CheckAnswer checkAnswer;

  @override
  _CheckAnswereCardState createState() => _CheckAnswereCardState();
}

class _CheckAnswereCardState extends State<CheckAnswereCard> {
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
            LeftTextBold(text: widget.checkAnswer.subject!),
            const SizedBox(height: 12),

            //TOPICS
            LeftTextBold(text: widget.checkAnswer.topics!),
            const SizedBox(height: 12),
            MarkdownView(
                resultText: widget.checkAnswer.yourQuestion!.originalProblem!),
            //LEVEL
            TextFireClock(
              color: ABColors.secondaryGoldYellow,
              text1: widget.checkAnswer.yourQuestion!.estimatedDifficulty!,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: widget.checkAnswer.yourQuestion!.estimatedTime!,
            ),
            const SizedBox(height: 28),

            //STEP
            MarkdownView(
                resultText: widget.checkAnswer.yourAnswer!.originalAnswer!),
            const SizedBox(height: 12),
            LeftTextBold(
                text: widget.checkAnswer.answerVerification!.statement!),
            const SizedBox(height: 12),
            LeftTextBold(
                text: widget.checkAnswer.answerVerification!.comparison!),
          ],
        ),
      ),
    );
  }
}
