class CheckAnswer {
  String? subject;
  String? topik;
  Question? question;
  String? content;

  CheckAnswer({this.subject, this.topik, this.question, this.content});

  CheckAnswer.fromJson(Map<String, dynamic> json) {
    subject = json['Subject'];
    topik = json['Topik'];
    question = json['Question'] != null
        ? new Question.fromJson(json['Question'])
        : null;
    content = json['Content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Subject'] = this.subject;
    data['Topik'] = this.topik;
    if (this.question != null) {
      data['Question'] = this.question!.toJson();
    }
    data['Content'] = this.content;
    return data;
  }
}

class Question {
  String? content;
  int? complexity;
  String? time;

  Question({this.content, this.complexity, this.time});

  Question.fromJson(Map<String, dynamic> json) {
    content = json['Content'];
    complexity = json['Complexity'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Content'] = this.content;
    data['Complexity'] = this.complexity;
    data['Time'] = this.time;
    return data;
  }
}
