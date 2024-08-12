class CheckAnswer {
  String? subject;
  String? topics;
  YourQuestion? yourQuestion;
  YourAnswer? yourAnswer;
  AnswerVerification? answerVerification;

  CheckAnswer(
      {this.subject,
      this.topics,
      this.yourQuestion,
      this.yourAnswer,
      this.answerVerification});

  CheckAnswer.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    topics = json['topics'];
    yourQuestion = json['yourQuestion'] != null
        ? new YourQuestion.fromJson(json['yourQuestion'])
        : null;
    yourAnswer = json['yourAnswer'] != null
        ? new YourAnswer.fromJson(json['yourAnswer'])
        : null;
    answerVerification = json['answerVerification'] != null
        ? new AnswerVerification.fromJson(json['answerVerification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['topics'] = this.topics;
    if (this.yourQuestion != null) {
      data['yourQuestion'] = this.yourQuestion!.toJson();
    }
    if (this.yourAnswer != null) {
      data['yourAnswer'] = this.yourAnswer!.toJson();
    }
    if (this.answerVerification != null) {
      data['answerVerification'] = this.answerVerification!.toJson();
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

class YourAnswer {
  String? originalAnswer;

  YourAnswer({this.originalAnswer});

  YourAnswer.fromJson(Map<String, dynamic> json) {
    originalAnswer = json['originalAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalAnswer'] = this.originalAnswer;
    return data;
  }
}

class AnswerVerification {
  String? statement;
  String? comparison;

  AnswerVerification({this.statement, this.comparison});

  AnswerVerification.fromJson(Map<String, dynamic> json) {
    statement = json['statement'];
    comparison = json['comparison'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statement'] = this.statement;
    data['comparison'] = this.comparison;
    return data;
  }
}
