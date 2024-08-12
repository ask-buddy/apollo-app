class SolveResponse {
  String? subject;
  String? topics;
  YourQuestion? yourQuestion;
  String? solutionSteps;
  String? detailedExplanation;

  SolveResponse(
      {this.subject,
      this.topics,
      this.yourQuestion,
      this.solutionSteps,
      this.detailedExplanation});

  SolveResponse.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    topics = json['topics'];
    yourQuestion = json['yourQuestion'] != null
        ? new YourQuestion.fromJson(json['yourQuestion'])
        : null;
    solutionSteps = json['solutionSteps'];
    detailedExplanation = json['detailedExplanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['topics'] = this.topics;
    if (this.yourQuestion != null) {
      data['yourQuestion'] = this.yourQuestion!.toJson();
    }
    data['solutionSteps'] = this.solutionSteps;
    data['detailedExplanation'] = this.detailedExplanation;
    return data;
  }
}

class YourQuestion {
  String? originalProblem;
  String? estimatedDifficulty;
  String? estimatedTime;

  YourQuestion(
      {this.originalProblem, this.estimatedDifficulty, this.estimatedTime});

  YourQuestion.fromJson(Map<String, dynamic> json) {
    originalProblem = json['originalProblem'];
    estimatedDifficulty = json['estimatedDifficulty'];
    estimatedTime = json['estimatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalProblem'] = this.originalProblem;
    data['estimatedDifficulty'] = this.estimatedDifficulty;
    data['estimatedTime'] = this.estimatedTime;
    return data;
  }
}
