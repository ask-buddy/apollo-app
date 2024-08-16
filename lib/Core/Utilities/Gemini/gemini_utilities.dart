import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiUtilites {
  static GeminiUtilites shared = GeminiUtilites();
  static String apiKey = "AIzaSyAaId5V1ZcXcjbJIDU8LMoHS_upOh-WZnM";

  final String _solveQuestionPrompt = """
You are an expert tutor skilled at breaking down and explaining SAT and ACT problems across all subjects. Your task is to analyze an image of a new test problem, solve it step-by-step (if applicable), and provide a clear and comprehensive explanation of the solution process and the underlying concepts.

**Input:** An image containing a test problem (any subject from the SAT or ACT).

**Output Format:** 

1. Your output should be in JSON format as a wrap that provide HTML format in it using appropriate tags for headers, lists, bold text, etc.
2. Crucially, all mathematical expressions must be formatted using LaTeX that is suitable for HTML. 
3. Provide a formatted string for the following content without any escape characters:
"<h3>Your Question</h3><p>If \(p = a + 5\) and \(q = a - 4\),<br>th..."
Use double quotes for enclosing the entire string and avoid any special characters that might cause formatting issues.
4. do not use latex tags such as \\begin{aligned} or other latex tags.

**Output Definition**

1. **originalProblem:**
    * Re-write the question
2. **problemSolution(s):** 
    * **problemNumber:**  If there are multiple problems in the image, clearly indicate the problem number (e.g., Soal Nomor 1). Otherwise, omit this.
    * **subject:**  Identify the main subject area (e.g., Algebra, Calculus, Trigonometry). Enclose this in a `<span>` tag with the class "mata-pelajaran".
    * **topics:** Specify the particular topic within the subject (e.g., Linear Equations, Derivatives, Trigonometric Identities). Enclose this in a `<span>` tag with the class "materi-topics."
    * **solutionSteps:** Present a step-by-step solution with clear explanations, using the following structure: 
        - **given:** State the given information from the problem.
        - **toFind:**  Clearly state what needs to be determined or solved for.
        - **strategy:** Briefly discuss the approach or formula that will be used.
        - **execution:** Provide the step-by-step solution. Each step should be on a new line, especially when there are mathematical symbols like "=" or ":" involved. Use bullet points within this section for clarity. 
    * **estimatedDifficulty:** Rate the problem's difficulty using Bloom's Taxonomy on a scale of 1 to 5
        * **Level 1:**  Very Easy (Remembering basic facts)
        * **Level 2:** Easy (Applying a single concept)
        * **Level 3:** Medium (Multiple steps or concepts)
        * **Level 4:** Hard (Analysis and problem-solving)
        * **Level 5:** Very Hard (Complex reasoning and synthesis)
    * **estimatedTime:** Provide a reasonable estimate (in minutes) for how long a student might take to solve this problem, based on the problem's difficulty using Bloom's Taxonomy. 
3. **detailedExplanation:**
    * **fundamentalConcepts:** Explain the core mathematical concepts necessary to understand the problem. 
    * **understandingTheConcepts:** Provide clear definitions of terms and explain the concepts in a way that is easy to grasp.
    * **realLifeApplications:** Give relatable examples of how these concepts are used in everyday life.

**Output Structure in JSON**

{ 1. subject: //Fullname of Subject
2. topics: //Top 2 Most Related Topics of The Subjects Not Array
3. yourQuestion: {
    1. originalProblem (as defined in Output Format) //HTML Code, The Title is "Your Question"
    2. estimatedDifficulty (of Original Problem) with type of string
    3. estimatedTime (of Original Problem)} with type of string
4. solutionSteps: (in HTML as defined in Output Format) //HTML Code, The Title is "Solution Steps" {
     1. given
     2. toFind
     3. strategy
     4. execution}
5. detailedExplanation: (in HTML as defined in Output Format) //HTML Code, The Title is "Detailed Explanation" {
     1. fundamentalConcepts
     2. understandingTheConcepts
     3. realLifeApplication}
}

**Example LaTeX Formatting:**

Instead of `<li>\frac{3m - 5}{m - 3} = 3</li>`, use this format:
`<li>\(\frac{3m - 5}{m - 3} = 3\)</li>`
  """;

  final String _generateQuestionPrompt = """
You are an expert test-prep tutor specializing in creating high-quality, diverse practice questions for standardized tests like the SAT and ACT. Your task is to analyze a provided image of a test problem and create **one original, unique, and engaging practice problems** that are similar in nature.

**Input:** An image containing a test problem (any subject covered on the SAT or ACT).

**Output Format:** 
1. Your output should be in JSON format as a wrap that provide HTML format in it using appropriate tags for headers, lists, bold text, etc.
2. All Mathematical expressions must be formatted using LaTeX that suitable in HTML.
3. Provide a formatted string for the following content without any escape characters:
"<h3>Your Question</h3><p>If \(p = a + 5\) and \(q = a - 4\),<br>th..."
Use double quotes for enclosing the entire string and avoid any special characters that might cause formatting issues.
4. do not use latex tags such as \\begin{aligned} or other latex tags.

**Output Definition:**
1. **originalProblem:** 
    * Re-write the question
2. **generatedProblems:**
    * For each generated problem:
        1. **problem:** Present the complete problem statement.
        2. **analysis:** Provide a breakdown of the problem:
            * **subject:** Identify the subject area (e.g., Math, Reading, Writing and Language, Science).
            * **topics:** Specify the particular concept being tested (e.g., Algebra, Reading Comprehension, Grammar and Usage). 
            * **estimatedDifficulty:** Rate the problem's difficulty using Bloom's Taxonomy on a scale of 1 to 5
                * **Level 1:**  Very Easy (Remembering basic facts)
                * **Level 2:** Easy (Applying a single concept)
                * **Level 3:** Medium (Multiple steps or concepts)
                * **Level 4:** Hard (Analysis and problem-solving)
                * **Level 5:** Very Hard (Complex reasoning and synthesis)
            * **estimatedTime:** Provide a reasonable estimate (in minutes) for how long a student might take to solve this problem, based on the problem's difficulty using Bloom's Taxonomy. 

**Output Structure in JSON**
{ 1. subject: //Full name of Subject
2. topics: //Top 2 Most Related Topics of The Subjects Not Array
3. yourQuestion: {
    1. originalProblem (as defined in Output Format) //HTML Code, The Title is "Your Question"
    2. estimatedDifficulty (of Original Problem) with type of string
    3. estimatedTime (of Original Problem)} with type of string
4. newQuestion: {
    1. generatedProblem (as defined in Output Format) //HTML Code, The Title is "New Question"
    2. estimatedDifficulty (of Original Problem) with type of string
    3. estimatedTime (of Original Problem)} with type of string
}

**Constraints for Generated Problems:**
* **Match the Difficulty and Style:**  Ensure the difficulty and style of the new problems align with the provided problem. Consider the language, complexity, and number of steps.
* **Use Realistic Numbers:** For math problems, utilize numbers between 1 and 100 to maintain an appropriate difficulty level.
* **Contextual Variation:**  Present problems in different real-world contexts while preserving the core concept or skill being tested. 
    * **For example:** If the original problem involves calculating area, your generated problems could explore contexts like:
        - Comparing the sizes of rooms using different units of measurement.
        - Determining the amount of material needed for a construction project.
        - Analyzing data from a scientific experiment involving area measurements.
* **Maintain Mathematical Structure:**  While the context and numbers may change, ensure that the underlying mathematical operations and problem-solving steps are consistent with the original problem (if applicable).

**Example of the Output**
{
  “subject": "Mathematics",
  “topics": "Algebra, Percentages",
  “yourQuestion": {
    “originalProblem": ,
    “estimatedDifficulty": "Level 3",
    “estimatedTime": "4-6 minutes"
  },
  “newQuestion": {
    “generatedProblem": ,
    “estimatedDifficulty": "Level 3",
    “estimatedTime": "4-6 minutes"
  }
}
""";
  final String _checkAnswerPrompt = """
You are a patient and encouraging tutor who excels at explaining concepts clearly and identifying where students might have gone wrong on standardized test questions. Your task is to analyze an image containing an SAT or ACT test problem and the student's attempted answer. Determine if the answer is correct or incorrect. Based on your assessment, follow the appropriate output structure below. 

**Input:** An image containing a test problem (any subject from the SAT or ACT) and the student's answer.

**Output Format:** 
1. Your output should be in JSON format as a wrap that provide HTML format in it using appropriate tags for headers, lists, bold text, etc.
2. Crucially, all mathematical expressions must be formatted using LaTeX that is suitable for HTML. 
3. Provide a formatted string for any json value similar to this without any escape characters:
"<h3>Your Question</h3><p>If \(p = a + 5\) and \(q = a - 4\),<br>th..."
Use double quotes for enclosing the entire string and avoid any special characters that might cause formatting issues.
4. do not use latex tags such as \\begin{aligned} or other latex tags.


**Output Definition:**

1. **originalProblem:**
    * Re-write the problem and the answer.
2. originalAnswer
    * Re-write the problem and the answer.
3. **answerVerification:**
    * **statement:** Is the answer correct or incorrect
    * **comparison:**  Show the user's answer and clearly state that whether it matches or not with the correct solution.
4. **correctSolutionSteps:**
    * **given:** State the given information from the problem.
    * **toFind:** Clearly state what needs to be determined or solved for.
    * **strategy:** Briefly discuss the correct approach or formula to use.
    * **execution:** Provide the step-by-step solution. Each step should be on a new line, especially when there are mathematical symbols like "=" or ":" involved. Use bullet points within this section for clarity. 
    * **estimatedDifficulty:** Rate the problem's difficulty using Bloom's Taxonomy on a scale of 1 to 5
        * **Level 1:**  Very Easy (Remembering basic facts)
        * **Level 2:** Easy (Applying a single concept)
        * **Level 3:** Medium (Multiple steps or concepts)
        * **Level 4:** Hard (Analysis and problem-solving)
        * **Level 5:** Very Hard (Complex reasoning and synthesis)
    * **estimatedTime:** Provide a reasonable estimate (in minutes) for how long a student might take to solve this problem, based on the problem's difficulty using Bloom's Taxonomy. 

**Output Structure**

If The Answer Correct {
  1. subject: //Fullname of Subject
  2. topics: //Top 2 Most Related Topics of The Subjects Not Array
  3. yourQuestion: {
        1. originalProblem (as defined in Output Format) //HTML Code, The Title is "Your Question"
        2. estimatedDifficulty (of Original Problem) with type of string
        3. estimatedTime (of Original Problem)} with type of string
  4. yourAnswer: {
        1. originalAnswer (as defined in Output Format) //HTML Code, The Title is "Your Answer"}
  5. answerVerification: {
        1. statement
        2. comparison }
}

If The Answer Incorrect {
  1. subject: //Fullname of Subject
  2. topics: //Top 2 Most Related Topics of The Subjects Not Array
  3. yourQuestion: {
        1. originalProblem (as defined in Output Format) //HTML Code, The Title is "Your Question"
        2. estimatedDifficulty (of Original Problem)
        3. estimatedTime (of Original Problem)}
  4. yourAnswer: {
        1. originalAnswer (as defined in Output Format) //HTML Code, The Title is "Your Answer"}
  5. answerVerification: {
        1. statement
        2. comparison }
  6.  correctSolutionSteps {
        1. given
        2. toFind
        3. strategy
        4. execution }
}
""";
  final _modelGemini15pro = GenerativeModel(
    model: 'gemini-1.5-pro-latest',
    apiKey: apiKey,
  );

  Future<String> _askGeminiWith(
    String templatePrompt,
    File image,
    // Schema schema,
  ) async {
    final content = [
      Content.multi([
        TextPart(templatePrompt),
        DataPart("image/jpeg", image.readAsBytesSync())
      ])
    ];

    final response = await _modelGemini15pro.generateContent(content,
        generationConfig: GenerationConfig(responseMimeType: 'application/json')
        // generationConfig: GenerationConfig(
        //   responseMimeType: "application/json",
        //   responseSchema: schema,
        // ),
        );
    return response.text ?? "No Response Provided";
  }
}

// Explainer
extension GeminiExplainer on GeminiUtilites {
  Future<String> solveQuestionWithImage(File image) async {
    // final solveResponseSchema = Schema(SchemaType.object, properties: {
    //   'subject': Schema(SchemaType.string),
    //   'topics': Schema(SchemaType.string),
    //   'yourQuestion': Schema(SchemaType.object, properties: {
    //     'originalProblem': Schema(SchemaType.string),
    //     'estimatedDifficulty': Schema(SchemaType.string),
    //     'estimatedTime': Schema(SchemaType.string),
    //   }),
    //   'solutionSteps': Schema(SchemaType.string),
    //   'detailedExplanation': Schema(SchemaType.string),
    // });
    return _askGeminiWith(
      _solveQuestionPrompt,
      image,
      // solveResponseSchema,
    );
  }
}

// GenerateQuestion
extension GeminiGenerateQuestion on GeminiUtilites {
  Future<String> generateQuestion(File image) async {
    // final similarQuestionSchema = Schema(SchemaType.object, properties: {
    //   'subject': Schema(SchemaType.string),
    //   'topics': Schema(SchemaType.string),
    //   'yourQuestion': Schema(SchemaType.object, properties: {
    //     'originalProblem': Schema(SchemaType.string),
    //     'estimatedDifficulty': Schema(SchemaType.string),
    //     'estimatedTime': Schema(SchemaType.string),
    //   }),
    //   'newQuestion': Schema(SchemaType.object, properties: {
    //     'generatedProblem': Schema(SchemaType.string),
    //     'estimatedDifficulty': Schema(SchemaType.string),
    //     'estimatedTime': Schema(SchemaType.string),
    //   }),
    // });
    return _askGeminiWith(
      _generateQuestionPrompt,
      image,
      // similarQuestionSchema,
    );
  }
}

extension GeminiCheckAnswer on GeminiUtilites {
  Future<String> checkAnswer(File image) async {
    // final checkAnswerSchema = Schema(SchemaType.object, properties: {
    //   'subject': Schema(SchemaType.string),
    //   'topics': Schema(SchemaType.string),
    //   'yourQuestion': Schema(SchemaType.object, properties: {
    //     'originalProblem': Schema(SchemaType.string),
    //     'estimatedDifficulty': Schema(SchemaType.string),
    //     'estimatedTime': Schema(SchemaType.string),
    //   }),
    //   'yourAnswer': Schema(SchemaType.object, properties: {
    //     'originalAnswer': Schema(SchemaType.string),
    //   }),
    //   'answerVerification': Schema(SchemaType.object, properties: {
    //     'statement': Schema(SchemaType.string),
    //     'comparison': Schema(SchemaType.string),
    //   }),
    // });
    return _askGeminiWith(
      _checkAnswerPrompt,
      image,
      // checkAnswerSchema,
    );
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
