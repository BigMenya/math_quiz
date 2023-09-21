import 'package:flutter/material.dart';
import 'package:math_quiz/feature/quiz_screen/bloc/quiz_screen_bloc.dart';
import 'package:math_quiz/feature/quiz_screen/widgets/quiz_question_widget.dart';

import '../../models/question_model.dart';

class QuizScreenWidget extends StatefulWidget {
  const QuizScreenWidget({super.key});

  @override
  State<QuizScreenWidget> createState() => _QuizScreenWidgetState();
}

class _QuizScreenWidgetState extends State<QuizScreenWidget> {
  final QuizScreenBloc _quizManager = QuizScreenBloc();

  @override
  void initState() {
    super.initState();
    _quizManager.loadQuestions(context);
  }

  @override
  void dispose() {
    _quizManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuizQuestionModel>>(
      stream: _quizManager.questionsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final currentQuestion =
            snapshot.data![_quizManager.currentQuestionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: QuizQuestionWidget(
              question: currentQuestion,
              onAnswerSelected: (answer) =>
                  _quizManager.handleAnswer(answer, context),
            ),
          ),
        );
      },
    );
  }
}
