import 'package:apollo_app/Core/Utilities/Helper/get_color_by_level.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constants/colors.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';
import 'package:apollo_app/Features/Chat/Model/check_answer.dart';

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
            // SUBJECT
            widget.checkAnswer.subject != null
                ? LeftTextBold(text: widget.checkAnswer.subject!)
                : const SizedBox(),

            const SizedBox(height: 12),

            // TOPICS
            widget.checkAnswer.topics != null
                ? LeftTextBold(text: widget.checkAnswer.topics!)
                : const SizedBox(),

            const SizedBox(height: 12),

            // ORIGINAL PROBLEM
            widget.checkAnswer.yourQuestion?.originalProblem != null
                ? MarkdownView(
                    resultText:
                        widget.checkAnswer.yourQuestion!.originalProblem!)
                : const SizedBox(),

            // LEVEL
            widget.checkAnswer.yourQuestion?.estimatedDifficulty != null &&
                    widget.checkAnswer.yourQuestion?.estimatedTime != null
                ? TextFireClock(
                    color: getDifficultyColor(
                        widget.checkAnswer.yourQuestion!.estimatedDifficulty!),
                    text1:
                        widget.checkAnswer.yourQuestion!.estimatedDifficulty!,
                    icon1: FontAwesomeIcons.fire,
                    icon2: FontAwesomeIcons.solidClock,
                    text2: widget.checkAnswer.yourQuestion!.estimatedTime!,
                  )
                : const SizedBox(),

            const SizedBox(height: 28),

            // ORIGINAL ANSWER
            widget.checkAnswer.yourAnswer?.originalAnswer != null
                ? MarkdownView(
                    resultText: widget.checkAnswer.yourAnswer!.originalAnswer!)
                : const SizedBox(),

            const SizedBox(height: 12),

            // ANSWER VERIFICATION STATEMENT
            widget.checkAnswer.answerVerification?.statement != null
                ? LeftTextBold(
                    text: widget.checkAnswer.answerVerification!.statement!)
                : const SizedBox(),

            const SizedBox(height: 12),

            // ANSWER VERIFICATION COMPARISON
            widget.checkAnswer.answerVerification?.comparison != null
                ? LeftTextBold(
                    text: widget.checkAnswer.answerVerification!.comparison!)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
