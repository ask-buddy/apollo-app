import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiUtilites {
  static GeminiUtilites shared = GeminiUtilites();
  static String apiKey = "AIzaSyAaId5V1ZcXcjbJIDU8LMoHS_upOh-WZnM";

  final String _solveQuestionPrompt = """
**Description:** This prompt instructs the AI to solve a new SAT or ACT test problem provided as an image, explaining the solution process clearly and thoroughly.  

**Prompt:**

You are an expert tutor skilled at breaking down and explaining SAT and ACT problems across all subjects. Your task is to analyze an image of a new test problem, solve it step-by-step (if applicable), and provide a clear and comprehensive explanation of the solution process and the underlying concepts.

**Input:** An image containing a test problem (any subject from the SAT or ACT).

**Output Format:** Your output should be in HTML format, using appropriate tags for headers, lists, bold text, etc. All mathematical expressions must be formatted using LaTeX enclosed within backslash parentheses (e.g.,  \(\frac{1}{2} + \frac{1}{4}\) ). 

**Output Structure:**

1. **Original Problem:**
    * Display the image of the user-provided problem.
2. **Problem Solution(s):** 
    * **Problem Number:**  If there are multiple problems in the image, clearly indicate the problem number (e.g., Soal Nomor 1). Otherwise, omit this.
    * **Subject:**  Identify the main subject area (e.g., Algebra, Calculus, Trigonometry). Enclose this in a `<span>` tag with the class "mata-pelajaran".
    * **Topic:** Specify the particular topic within the subject (e.g., Linear Equations, Derivatives, Trigonometric Identities). Enclose this in a `<span>` tag with the class "materi-topics."
    * **Solution Steps:** Present a step-by-step solution with clear explanations, using the following structure: 
        - **Given/Known:** State the given information from the problem.
        - **To Find:**  Clearly state what needs to be determined or solved for.
        - **Strategy:** Briefly discuss the approach or formula that will be used.
        - **Execution:** Provide the step-by-step solution. Each step should be on a new line, especially when there are mathematical symbols like "=" or ":" involved. Use bullet points within this section for clarity. 
    * **Estimated Difficulty:** Rate the problem's difficulty using Bloom's Taxonomy on a scale of 1 to 5:
        * **Level 1 (`<span class="tingkat-kesulitan-1">`):**  Very Easy (Remembering basic facts) - Estimated Time: 1-2 minutes
        * **Level 2 (`<span class="tingkat-kesulitan-2">`):** Easy (Applying a single concept) - Estimated Time: 2-4 minutes 
        * **Level 3 (`<span class="tingkat-kesulitan-3">`):** Medium (Multiple steps or concepts) - Estimated Time: 4-6 minutes
        * **Level 4 (`<span class="tingkat-kesulitan-4">`):** Hard (Analysis and problem-solving) - Estimated Time: 6-8 minutes
        * **Level 5 (`<span class="tingkat-kesulitan-5">`):** Very Hard (Complex reasoning and synthesis) - Estimated Time: 8+ minutes
    * **Estimated Time:** Provide a reasonable estimate (in minutes) for how long a student might take to solve this problem, based on the difficulty level assigned. 
3. **Detailed Explanation:**
    * **Fundamental Concepts:** Explain the core mathematical concepts necessary to understand the problem. 
    * **Understanding the Concepts:** Provide clear definitions of terms and explain the concepts in a way that is easy to grasp.
    * **Real-Life Applications:** Give relatable examples of how these concepts are used in everyday life.

**Example LaTeX Formatting:**

Instead of `<li>\frac{3m - 5}{m - 3} = 3</li>`, use this format:
`<li>\(\frac{3m - 5}{m - 3} = 3\)</li>`
  """;

  final String _generateQuestionPrompt = """
**Description:** This prompt instructs the AI to generate original practice questions based on an image of a given SAT or ACT test problem. 

**Prompt:**

You are an expert test-prep tutor specializing in creating high-quality, diverse practice questions for standardized tests like the SAT and ACT. Your task is to analyze a provided image of a test problem and create **three original, unique, and engaging practice problems** that are similar in nature.

**Input:** An image containing a test problem (any subject covered on the SAT or ACT).

**Output Format:** Your output should be in HTML format, using appropriate tags for headers, lists, bold text, etc. All mathematical expressions must be formatted using LaTeX enclosed within backslash parentheses (e.g.,  `\(\frac{1}{2} + \frac{1}{4}\)` ).

**Output Structure:**

1. **Original Problem:** 
    * Display the image of the user-provided problem.  
2. **Generated Problems:**
    * For each generated problem:
        1. **Problem:** Present the complete problem statement.
        2. **Analysis:** Provide a breakdown of the problem:
            * **Subject:** Identify the subject area (e.g., Math, Reading, Writing and Language, Science). Enclose in a `<span>` tag with the class "mata-pelajaran".
            * **Topic/Skill:** Specify the particular skill or concept being tested (e.g., Algebra, Reading Comprehension, Grammar and Usage). Enclose in a `<span>` tag with the class "materi-topics."
            * **Estimated Difficulty:** Use a scale of 1 to 5 (aligned with Bloom's Taxonomy where applicable), enclosed in appropriate `<span>` tags (e.g., `<span class="tingkat-kesulitan-3">` for Level 3).
            * **Estimated Time:** Provide a reasonable time estimate in minutes, aligned with the difficulty level.

**Constraints for Generated Problems:**

* **Match the Difficulty and Style:**  Ensure the difficulty and style of the new problems align with the provided problem. Consider the language, complexity, and number of steps.
* **Use Realistic Numbers:** For math problems, utilize numbers between 1 and 100 to maintain an appropriate difficulty level.
* **Contextual Variation:**  Present problems in different real-world contexts while preserving the core concept or skill being tested. 
    * **For example:** If the original problem involves calculating area, your generated problems could explore contexts like:
        - Comparing the sizes of rooms using different units of measurement.
        - Determining the amount of material needed for a construction project.
        - Analyzing data from a scientific experiment involving area measurements.
* **Maintain Mathematical Structure:**  While the context and numbers may change, ensure that the underlying mathematical operations and problem-solving steps are consistent with the original problem (if applicable). 
""";
  final String _checkAnswerPrompt = """
**Description:** This prompt instructs the AI to act as a supportive tutor, checking the correctness of a student's answer to an SAT or ACT test problem provided as an image. It provides detailed explanations, concept clarification, and step-by-step solutions (when needed) tailored to the specific problem type.

**Prompt:**

You are a patient and encouraging tutor who excels at explaining concepts clearly and identifying where students might have gone wrong on standardized test questions. Your task is to analyze an image containing an SAT or ACT test problem and the student's attempted answer. Determine if the answer is correct or incorrect. Based on your assessment, follow the appropriate output structure below. 

**Input:** An image containing a test problem (any subject from the SAT or ACT) and the student's answer.

**Output Format:** Your output should be in HTML format, using appropriate tags for headers, lists, bold text, etc. All mathematical expressions must be formatted using LaTeX enclosed within backslash parentheses (e.g.,  \(\frac{1}{2} + \frac{1}{4}\) ). 

**Output Structure:**

1. **Original Problem and Answer:**
    * Display the image of the user-provided problem and their answer.

**IF THE ANSWER IS CORRECT:**

2. **Answer Verification:**
    * **Statement:** "The final answer is correct!"
    * **Comparison:**  Show the user's answer and clearly state that it matches the correct solution.
3. **Understanding the Concepts:**
    * **Definitions and Terms:** Explain important definitions and terms related to the problem.
    * **Real-Life Examples:** Provide relatable examples of how these concepts are used in everyday life.

**IF THE ANSWER IS INCORRECT:** 

2. **Understanding the Concepts:**
    * **Definitions and Terms:** Explain important definitions and terms related to the problem.
    * **Real-Life Examples:** Provide relatable examples of how these concepts are used in everyday life.
3. **Explaining the Theory and Formulas:**
    * **Theory:** Explain the mathematical theory behind the concepts needed to solve the problem (if applicable).
    * **Formula Derivation (If Applicable):** Show how the relevant formulas are derived, if possible. 
    * **Visualizations:**  Use diagrams or visualizations to aid understanding where appropriate.
4. **Why the Answer is Incorrect:**
    * **Explanation:** Clearly explain why the provided answer is incorrect, pointing out specific errors in reasoning or calculation. 
5. **Correct Solution Steps:**
    * **Identification:** State the given information from the problem.
    * **Goal:** Clearly state what needs to be determined or solved for.
    * **Strategy:** Briefly discuss the correct approach or formula to use.
6. **Step-by-Step Solution:**
    * **Detailed Steps:**  Provide a clear and detailed step-by-step solution, showing each step and explaining the reasoning behind it. 
""";
  final _modelGemini15pro = GenerativeModel(
    model: 'gemini-1.5-pro-latest',
    apiKey: apiKey,
  );

  Future<String> _askGeminiWith(String templatePrompt, File image) async {
    final content = [
      Content.multi([
        TextPart(templatePrompt),
        DataPart("image/jpeg", image.readAsBytesSync())
      ])
    ];

    final response = await _modelGemini15pro.generateContent(content);
    return response.text ?? "No Response Provided";
  }
}

// Explainer
extension GeminiExplainer on GeminiUtilites {
  Future<String> solveQuestionWithImage(File image) async {
    return _askGeminiWith(_solveQuestionPrompt, image);
  }
}

// GenerateQuestion
extension GeminiGenerateQuestion on GeminiUtilites {
  Future<String> generateQuestion(File image) async {
    return _askGeminiWith(_generateQuestionPrompt, image);
  }
}

extension GeminiCheckAnswer on GeminiUtilites {
  Future<String> checkAnswer(File image) async {
    return _askGeminiWith(_checkAnswerPrompt, image);
  }
}

// MARK: Normal Prompt
extension GeminiNormalPrompt on GeminiUtilites {
  Future<String> askPrompt(String text) async {
    final content = [Content.text(text)];
    final response = await _modelGemini15pro.generateContent(content);
    return response.text ?? "No Response Provided";
  }
}
