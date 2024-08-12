// Placeholder file for creating folder
import 'package:apollo_app/Core/Widget/view/similar_question.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SimilarQuestionCard(
                subject: "MAth",
                topics: "Algebra",
                yourOriginalProblem: """
<h2>Your Question</h2><p>What is the value of  \\( \\lim_{x \\to \\frac{\\pi}{2}} \\frac{\\cos^2 x}{\\left( \\sin \\frac{1}{2}x - \\cos \\frac{1}{2}x \\right)^2} \\) ?</p>
""",
                yourEstimatedDifficulty: "Level 4",
                yourEstimatedTime: "5-7 minutes",
                newOriginalProblem: """
<h2>New Question</h2><p>Determine the value of the following limit:  \\( \\lim_{\\theta \\to \\pi} \\frac{\\sin^2 \\theta}{\\left( \\cos \\frac{1}{2}\\theta + \\sin \\frac{1}{2}\\theta \\right)^2} \\) </p>
""",
                newEstimatedDifficulty: "Level 4",
                newEstimatedTime: "5-7 minutes")
          ],
        ),
      ),
    );
  }
}
