import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_quiz/feature/summary_screen/summary_screen.dart';

import '../../../models/question_model.dart';

class QuizScreenBloc {
  final StreamController<List<QuizQuestionModel>> _questionsController =
      StreamController<List<QuizQuestionModel>>();

  Stream<List<QuizQuestionModel>> get questionsStream =>
      _questionsController.stream;

  List<QuizQuestionModel> _questions = [];
  int _currentQuestionIndex = 0;

  Future<void> loadQuestions(BuildContext context) async {
    try {
      final quizData = await DefaultAssetBundle.of(context)
          .loadString('assets/math_questions.json');
      final List<dynamic> jsonList = json.decode(quizData);
      final List<QuizQuestionModel> questions =
          jsonList.map((json) => QuizQuestionModel.fromJson(json)).toList();

      _questions = questions;
      _currentQuestionIndex = 0;

      _questionsController.add(_questions);
    } catch (e) {
      // Handle error loading questions
      print('Error loading questions: $e');
    }
  }

  int get currentQuestionIndex => _currentQuestionIndex;

  int _score = 0;

  int get score => _score;

  void handleAnswer(String selectedAnswer, BuildContext context) {


    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswer = currentQuestion.correctAnswer;

    if (selectedAnswer == correctAnswer) {
      _score++; // Увеличиваем счетчик очков при правильном ответе
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _questionsController.add(_questions);
    } else {
      // Все вопросы пройдены, переходим на экран результатов
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SummaryScreenWidget(score: _score),
        ),
      );
    }
  }

  void dispose() {
    _questionsController.close();
  }
}
