import 'package:apollo_app/Core/Utilities/Helper/get_color_by_level.dart';
import 'package:apollo_app/Features/Chat/Model/solve_response.dart';
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
    required this.solveResponse,
  });

  final SolveResponse solveResponse;

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
            LeftTextBold(text: widget.solveResponse.subject!),
            const SizedBox(height: 12),

            //TOPICS
            LeftTextBold(text: widget.solveResponse.topics!),
            const SizedBox(height: 12),
            MarkdownView(
                resultText:
                    widget.solveResponse.yourQuestion!.originalProblem!),
            //LEVEL
            TextFireClock(
              color: getDifficultyColor(
                  widget.solveResponse.yourQuestion!.estimatedDifficulty!),
              text1: widget.solveResponse.yourQuestion!.estimatedDifficulty!,
              icon1: FontAwesomeIcons.fire,
              icon2: FontAwesomeIcons.solidClock,
              text2: widget.solveResponse.yourQuestion!.estimatedTime!,
            ),
            const SizedBox(height: 28),

            //STEP
            MarkdownView(resultText: widget.solveResponse.solutionSteps!),
            //DETAIL EXPLANATION
            if (isExpanded)
              MarkdownView(
                  resultText: widget.solveResponse.detailedExplanation!),
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
