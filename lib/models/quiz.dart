import 'package:rest_api/rest_api.dart';

class Quiz extends Serializable {
  String name;
  List<QuizQuestion> questions;

  Quiz.fromJson(Map<String, dynamic> json) {
    name = json["name"] as String;
    questions = (json["questions"] as List<dynamic>)
        .map((question) =>
            QuizQuestion.fromJson(question as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, dynamic> asMap() {
    return {
      "name": name,
      "questions": questions.map((e) => e.asMap()).toList()
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    // TODO: implement readFromMap
  }
}

class QuizQuestion with Serializable {
  String question;
  List<String> answers;
  int correctAnswer;

  QuizQuestion.fromJson(Map<String, dynamic> json) {
    question = json["question"] as String;
    correctAnswer = json["correctAnswer"] as int;
    answers = json["answers"].cast<String>() as List<String>;
  }

  @override
  Map<String, dynamic> asMap() {
    return {
      "question": question,
      "answers": answers,
      "correctAnswer": correctAnswer
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    // TODO: implement readFromMap
  }
}
