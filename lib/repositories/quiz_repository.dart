import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:rest_api/models/quiz.dart';

class QuizRepository {
  static final QuizRepository _singleton = QuizRepository._internal();

  factory QuizRepository() => _singleton;

  List<Quiz> _quizzes;

  static Future<QuizRepository> initialize() async {
    final component = _singleton;

    try {
      final file = await File('data/quizzes.json').readAsString();
      final json = jsonDecode(file) as List<dynamic>;
      for (var quizJson in json) {
        component.addNewQuiz(Quiz.fromJson(quizJson as Map<String, dynamic>));
      }
    } catch (e) {
      print(e);
    }

    return component;
  }

  QuizRepository._internal() {
    _quizzes = [];
  }

  void addNewQuiz(Quiz quiz) {
    _quizzes.add(quiz);
  }

  Quiz getQuiz(int index) {
    return _quizzes[index];
  }

  Quiz getRandomQuiz() {
    return _quizzes[Random().nextInt(_quizzes.length)];
  }

  Quiz getQuizByName(String quizName) {
    return _quizzes.firstWhere((quiz) => quiz.name == quizName);
  }
}
