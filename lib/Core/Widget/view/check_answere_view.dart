import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constants/colors.dart';
import '../text/left_text_bold.dart';
import '../text/text_fire_clock.dart';
import 'markdown_view.dart';

class CheckAnswereCard extends StatefulWidget {
  const CheckAnswereCard({
    super.key,
    required this.subject,
    required this.topics,
    required this.originalProblem,
    required this.yourEstimatedDifficulty,
    required this.yourEstimatedTime,
    required this.originalAnswere,
    required this.statement,
    required this.comparison,
  });

  final String subject;
  final String topics;
  final String originalProblem;
  final String yourEstimatedDifficulty;
  final String yourEstimatedTime;
  final String originalAnswere;
  final String statement;
  final String comparison;

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
            LeftTextBold(text: widget.subject),
            const SizedBox(height: 12),

            //TOPICS
            LeftTextBold(text: widget.topics),
            const SizedBox(height: 12),
            MarkdownView(resultText: widget.originalProblem),
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
            MarkdownView(resultText: widget.originalAnswere),
            //DETAIL EXPLANATION
          ],
        ),
      ),
    );
  }
}
