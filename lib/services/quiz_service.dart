import 'package:rest_api/models/quiz.dart';
import 'package:rest_api/repositories/quiz_repository.dart';

class QuizService {
  Quiz getRandomQuiz() {
    return QuizRepository().getRandomQuiz();
  }
}
