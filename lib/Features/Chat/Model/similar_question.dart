class SimilarQuestion {
  String? subject;
  String? topik;
  YourQuestion? yourQuestion;
  YourQuestion? newQuestion;

  SimilarQuestion(
      {this.subject, this.topik, this.yourQuestion, this.newQuestion});

  SimilarQuestion.fromJson(Map<String, dynamic> json) {
    subject = json['Subject'];
    topik = json['Topik'];
    yourQuestion = json['YourQuestion'] != null
        ? new YourQuestion.fromJson(json['YourQuestion'])
        : null;
    newQuestion = json['NewQuestion'] != null
        ? new YourQuestion.fromJson(json['NewQuestion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Subject'] = this.subject;
    data['Topik'] = this.topik;
    if (this.yourQuestion != null) {
      data['YourQuestion'] = this.yourQuestion!.toJson();
    }
    if (this.newQuestion != null) {
      data['NewQuestion'] = this.newQuestion!.toJson();
    }
    return data;
  }
}

class YourQuestion {
  String? content;
  int? complexity;
  String? time;

  YourQuestion({this.content, this.complexity, this.time});

  YourQuestion.fromJson(Map<String, dynamic> json) {
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
