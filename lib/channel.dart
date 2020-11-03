import 'dart:io';

import 'package:aqueduct/managed_auth.dart';
import 'package:rest_api/controllers/motto_controller.dart';
import 'package:rest_api/controllers/quiz_controller.dart';
import 'package:rest_api/repositories/quiz_repository.dart';
import 'package:rest_api/services/motto_cache_service.dart';
import 'package:rest_api/services/quiz_service.dart';

import 'rest_api.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class RestApiChannel extends ApplicationChannel {
  MottoCacheService _mottoCacheService;
  QuizService _quizService;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    _mottoCacheService = MottoCacheService();
    _quizService = QuizService();
    await QuizRepository.initialize();
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    router.route('/').linkFunction((request) =>
        Response.ok('REST API is working.')..contentType = ContentType.html);

    router
        .route('/motto/[:json]')
        .link(() => MottoController(_mottoCacheService));

    router.route('/quiz').link(() => QuizController(_quizService));

    return router;
  }
}
