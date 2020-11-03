import 'package:rest_api/rest_api.dart';
import 'package:rest_api/services/quiz_service.dart';

class QuizController extends ResourceController {
  final QuizService _quizService;

  QuizController(this._quizService);

  @Operation.get()
  Future<Response> getRandomQuiz() async {
    final randomQuiz = _quizService.getRandomQuiz();
    if (randomQuiz == null) {
      return Response.notFound();
    } else {
      return Response.ok(randomQuiz);
    }
  }
}
