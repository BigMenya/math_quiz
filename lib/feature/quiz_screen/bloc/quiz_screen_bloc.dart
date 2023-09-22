import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_quiz/data/provider/questions_provider.dart';
import 'package:math_quiz/data/repository/best_scores_repository.dart';
import 'package:math_quiz/models/best_scores_model.dart';
import 'package:math_quiz/models/quiz_screen_state.dart';

import '../../../models/question_model.dart';

abstract class QuizScreenBloc {
  Future<void> init(BuildContext context);

  void handleAnswer(String selectedAnswer, BuildContext context);

  Stream<QuizScreenState> get questionsStream;

  int get currentQuestionIndex;

  int get score;

  bool get isLastQuestion;

  Future<void> onStartQuizPressed(String name);

  void dispose();
}

class QuizScreenBlocImpl implements QuizScreenBloc {
  QuizScreenBlocImpl(BestScoresRepository bestScoresRepository)
      : _bestScoresRepository = bestScoresRepository;

  // controllers
  final StreamController<QuizScreenState> _questionsController =
      StreamController<QuizScreenState>.broadcast();
  final _quizScreenState = QuizScreenState();
  final QuestionProvider _questionProvider = QuestionProviderImpl();
  final BestScoresRepository _bestScoresRepository;

  // states related
  List<QuizQuestionModel> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  Stream<QuizScreenState> get questionsStream => _questionsController.stream;

  @override
  Future<void> init(BuildContext context) async {
    _questions = await _questionProvider.loadQuestions(context);
    _bestScoresRepository.loadBestScoresList();
  }

  @override
  int get currentQuestionIndex => _currentQuestionIndex;

  @override
  int get score => _score;

  @override
  Future<void> handleAnswer(String selectedAnswer, BuildContext context) async {
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
      final state = await _questionsController.stream.last;
      await _bestScoresRepository
          .saveBestScoresList(BestScoresModel(state.name ?? '', _score));
    }
  }

  @override
  Future<void> onStartQuizPressed(String name) async {
    _questionsController.add(_quizScreenState.copyWith(
      name: name,
      questionsList: name.isNotEmpty ? _questions : null,
    ));
  }

  @override
  void dispose() {
    _questionsController.close();
  }

  @override
  bool get isLastQuestion => !(_currentQuestionIndex < _questions.length - 1);
}
