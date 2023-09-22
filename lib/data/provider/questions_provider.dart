import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/question_model.dart';

abstract class QuestionProvider {
  Future<List<QuizQuestionModel>> loadQuestions(BuildContext context);
}

class QuestionProviderImpl implements QuestionProvider {
  @override
  Future<List<QuizQuestionModel>> loadQuestions(BuildContext context) async {
    try {
      final quizData = await DefaultAssetBundle.of(context)
          .loadString('assets/math_questions.json');
      final List<dynamic> jsonList = json.decode(quizData);
      final List<QuizQuestionModel> questions =
          jsonList.map((json) => QuizQuestionModel.fromJson(json)).toList();

      return questions;
    } catch (e) {
      print('Error loading questions: $e');
      return [];
    }
  }
}
