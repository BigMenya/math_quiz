import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_quiz/data/provider/questions_provider.dart';
import 'package:math_quiz/data/repository/best_scores_repository.dart';
import 'package:math_quiz/feature/summary_screen/summary_screen.dart';
import 'package:math_quiz/models/quiz_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/question_model.dart';

abstract class QuizScreenBloc {
  Future<void> init(BuildContext context);

  void handleAnswer(String selectedAnswer, BuildContext context);

  Stream<QuizScreenState> get questionsStream;

  int get currentQuestionIndex;

  int get score;

  Future<void> onStartQuizPressed(bool nameAccepted);

  void dispose();
}

class QuizScreenBlocImpl implements QuizScreenBloc {
  // controllers
  final StreamController<QuizScreenState> _questionsController =
      StreamController<QuizScreenState>();
  final _quizScreenState = QuizScreenState();
  final QuestionProvider _questionProvider = QuestionProviderImpl();
  late final BestScoresRepository _bestScoresRepository;

  // states related
  List<QuizQuestionModel> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  Stream<QuizScreenState> get questionsStream => _questionsController.stream;

  @override
  Future<void> init(BuildContext context) async {
    _questions = await _questionProvider.loadQuestions(context);
    _bestScoresRepository =
        BestScoresRepositoryImpl(await SharedPreferences.getInstance());
  }

  @override
  int get currentQuestionIndex => _currentQuestionIndex;

  @override
  int get score => _score;

  @override
  void handleAnswer(String selectedAnswer, BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswer = currentQuestion.correctAnswer;

    if (selectedAnswer == correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _questionsController
          .add(_quizScreenState.copyWith(questionsList: _questions));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SummaryScreenWidget(score: _score),
        ),
      );
    }
  }

  @override
  Future<void> onStartQuizPressed(bool nameAccepted) async {
    _questionsController.add(_quizScreenState.copyWith(
        nameAccepted: nameAccepted,
        questionsList: nameAccepted ? _questions : null));
  }

  @override
  void dispose() {
    _questionsController.close();
  }
}
