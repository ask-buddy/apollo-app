class QuestionResponse {
  String? content;
  int? complexity;
  String? time;

  QuestionResponse({this.content, this.complexity, this.time});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
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
