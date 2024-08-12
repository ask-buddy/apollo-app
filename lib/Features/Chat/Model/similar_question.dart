class SimilarQuestion {
  String? subject;
  String? topics;
  YourQuestion? yourQuestion;
  NewQuestion? newQuestion;

  SimilarQuestion(
      {this.subject, this.topics, this.yourQuestion, this.newQuestion});

  SimilarQuestion.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    topics = json['topics'];
    yourQuestion = json['yourQuestion'] != null
        ? new YourQuestion.fromJson(json['yourQuestion'])
        : null;
    newQuestion = json['newQuestion'] != null
        ? new NewQuestion.fromJson(json['newQuestion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['topics'] = this.topics;
    if (this.yourQuestion != null) {
      data['yourQuestion'] = this.yourQuestion!.toJson();
    }
    if (this.newQuestion != null) {
      data['newQuestion'] = this.newQuestion!.toJson();
    }
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

class NewQuestion {
  String? generatedProblem;
  String? estimatedDifficulty;
  String? estimatedTime;

  NewQuestion(
      {this.generatedProblem, this.estimatedDifficulty, this.estimatedTime});

  NewQuestion.fromJson(Map<String, dynamic> json) {
    generatedProblem = json['generatedProblem'];
    estimatedDifficulty = json['estimatedDifficulty'];
    estimatedTime = json['estimatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generatedProblem'] = this.generatedProblem;
    data['estimatedDifficulty'] = this.estimatedDifficulty;
    data['estimatedTime'] = this.estimatedTime;
    return data;
  }
}
