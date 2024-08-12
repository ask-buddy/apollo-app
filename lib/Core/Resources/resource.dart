// Placeholder file for creating folder
import 'package:apollo_app/Core/Widget/view/similar_question.dart';
import 'package:apollo_app/Core/Widget/view/solve_question_view.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SolveQuestionCard(
                subject: "subject",
                topics: "topics",
                yourEstimatedDifficulty: "4",
                yourEstimatedTime: "4-5 menit",
                solutionSteps: """
<h3>Solution Steps</h3>\
        <ul>\
        <li><b>Given:</b> The expression \\(\\sqrt{\\frac{5}{6}} - 2\\sqrt{\\frac{1}{6}}\\)</li>\
        <li><b>To Find:</b> The simplified form of the expression.</li>\
        <li><b>Strategy:</b>\
        <ul>\
            <li>Simplify the radicals.</li>\
            <li>Combine like terms.</li>\
            <li>Rationalize the denominator (if necessary).</li>\
        </ul>\
        </li>\
        <li><b>Execution:</b>\
            <ul>\
            <li>Simplify each radical term:\
                \\(\\sqrt{\\frac{5}{6}} - 2\\sqrt{\\frac{1}{6}} = \\frac{\\sqrt{5}}{\\sqrt{6}} - \\frac{2\\sqrt{1}}{\\sqrt{6}} = \\frac{\\sqrt{5}}{\\sqrt{6}} - \\frac{2}{\\sqrt{6}}\\)</li>\
            <li>Since the radicals in the denominators are the same, we can combine the numerators:\
                \\(\\frac{\\sqrt{5}}{\\sqrt{6}} - \\frac{2}{\\sqrt{6}} = \\frac{\\sqrt{5} - 2}{\\sqrt{6}}\\)</li>\
            <li>Rationalize the denominator by multiplying by \\(\\frac{\\sqrt{6}}{\\sqrt{6}}\\):\
                \\(\\frac{\\sqrt{5} - 2}{\\sqrt{6}} \\times \\frac{\\sqrt{6}}{\\sqrt{6}} = \\frac{\\sqrt{30} - 2\\sqrt{6}}{6}\\)</li>\
            </ul>\
        </li>\
        </ul>
""",
                detailedExplanation: """
<h3>Detailed Explanation</h3>\
        <h4>Fundamental Concepts</h4>\
        <p>This problem involves several key concepts in algebra:</p>\
        <ul>\
            <li><span class=\"materi-topics\">Simplifying Radicals:</span>  The process of expressing a radical expression in its simplest form.  This often involves finding perfect square factors within a radical.</li>\
            <li><span class=\"materi-topics\">Rationalizing Denominators:</span>  The process of eliminating radicals from the denominator of a fraction. This is typically done by multiplying both the numerator and denominator by a suitable radical expression.</li>\
        </ul>\
        \
        <h4>Understanding the Concepts</h4>\
        <ul>\
        <li><b>Radicals:</b>  A radical (like the square root) is the opposite operation of an exponent. For example, the square root of 9 (√9) is 3 because 3 * 3 = 9.</li>\
        <li><b>Rationalizing: </b>In math, it's considered simpler to have a rational number in the denominator of a fraction. To get rid of a radical in the denominator, we multiply by a factor that will create a perfect square under the radical, allowing us to simplify.</li>\
        </ul>\
        \
        <h4>Real Life Applications</h4>\
        <p>While you might not simplify radicals daily, these concepts are foundational in algebra and appear in various fields:</p>\
        <ul>\
            <li><b>Engineering:</b>  Radicals are used extensively in formulas for calculations related to areas, volumes, and signal processing.</li>\
            <li><b>Physics:</b> Calculations involving gravity, motion, and energy frequently utilize radicals.</li>\
            <li><b>Computer Science:</b>  Algorithms, data structures, and computational geometry sometimes involve working with and simplifying radicals.</li>\
        </ul>
""")
          ],
        ),
      ),
    );
  }
}
