import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_quiz/feature/summary_screen/summary_screen.dart';
import 'package:math_quiz/models/quiz_screen_state.dart';

import '../../../models/question_model.dart';

abstract class QuizScreenBloc {
  Future<void> loadQuestions(BuildContext context);

  void handleAnswer(String selectedAnswer, BuildContext context);

  Stream<QuizScreenState> get questionsStream;

  int get currentQuestionIndex;

  int get score;

  Future<void> onStartQuizPressed(bool nameAccepted);

  void dispose();
}

class QuizScreenBlocImpl implements QuizScreenBloc {
  final StreamController<QuizScreenState> _questionsController =
      StreamController<QuizScreenState>();
  final _quizScreenState = QuizScreenState();

  List<QuizQuestionModel> _questions = [];
  int _currentQuestionIndex = 0;

  @override
  Stream<QuizScreenState> get questionsStream => _questionsController.stream;

  @override
  Future<void> loadQuestions(BuildContext context) async {
    try {
      final quizData = await DefaultAssetBundle.of(context)
          .loadString('assets/math_questions.json');
      final List<dynamic> jsonList = json.decode(quizData);
      final List<QuizQuestionModel> questions =
          jsonList.map((json) => QuizQuestionModel.fromJson(json)).toList();

      _questions = questions;
      _currentQuestionIndex = 0;
    } catch (e) {
      print('Error loading questions: $e');
    }
  }

  @override
  int get currentQuestionIndex => _currentQuestionIndex;

  int _score = 0;

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
