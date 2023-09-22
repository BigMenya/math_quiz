import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_quiz/data/provider/questions_provider.dart';
import 'package:math_quiz/data/repository/best_scores_repository.dart';
import 'package:math_quiz/models/best_scores_model.dart';
import 'package:math_quiz/models/quiz_screen_state.dart';

import '../../../models/question_model.dart';

abstract class QuizScreenBloc {
  Future<void> init(BuildContext context);

  Future<void> handleAnswer(String selectedAnswer);

  Stream<QuizScreenState> get questionsStream;

  Stream<double> get progressStream;

  int get currentQuestionIndex;

  int get score;

  bool get isLastQuestion;

  Future<void> onStartQuizPressed(String name);

  Future<void> saveScore();

  void dispose();
}

class QuizScreenBlocImpl implements QuizScreenBloc {
  QuizScreenBlocImpl(BestScoresRepository bestScoresRepository)
      : _bestScoresRepository = bestScoresRepository;

  // controllers
  final StreamController<QuizScreenState> _questionsController =
      StreamController<QuizScreenState>.broadcast();
  final StreamController<double> _progressController =
  StreamController<double>.broadcast();
  final _quizScreenState = QuizScreenState();
  final QuestionProvider _questionProvider = QuestionProviderImpl();
  final BestScoresRepository _bestScoresRepository;

  // states related
  List<QuizQuestionModel> _questions = [];
  int _currentQuestionIndex = 0;
  bool _isLastQuestion = false;
  int _score = 0;
  String? _userName;

  @override
  Stream<QuizScreenState> get questionsStream => _questionsController.stream;

  @override
  Future<void> init(BuildContext context) async {
    _questions = await _questionProvider.loadQuestions(context);
  }

  @override
  int get currentQuestionIndex => _currentQuestionIndex;

  @override
  int get score => _score;

  @override
  Future<void> handleAnswer(String selectedAnswer) async {
    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswer = currentQuestion.correctAnswer;

    if (selectedAnswer == correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _questionsController
          .add(_quizScreenState.copyWith(questionsList: _questions));
      _progressController.add(_currentQuestionIndex / 10);
    } else {
      _isLastQuestion = true;
    }
  }

  @override
  Future<void> onStartQuizPressed(String name) async {
    _questionsController.add(_quizScreenState.copyWith(
      name: name,
      questionsList: name.isNotEmpty ? _questions : null,
    ));
    _userName = name;
  }

  @override
  void dispose() {
    _questionsController.close();
  }

  @override
  bool get isLastQuestion => _isLastQuestion;

  @override
  Future<void> saveScore() async {
    await _bestScoresRepository
        .saveBestScoresList(BestScoresModel(_userName ?? '', _score));
  }

  @override
  Stream<double> get progressStream => _progressController.stream;
}
