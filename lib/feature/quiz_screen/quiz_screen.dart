import 'package:flutter/material.dart';
import 'package:math_quiz/feature/quiz_screen/bloc/quiz_screen_bloc.dart';
import 'package:math_quiz/feature/quiz_screen/widgets/quiz_question_widget.dart';
import 'package:math_quiz/feature/quiz_screen/widgets/start_quiz_widget.dart';
import 'package:math_quiz/models/quiz_screen_state.dart';


class QuizScreenWidget extends StatefulWidget {
  const QuizScreenWidget({super.key});

  @override
  State<QuizScreenWidget> createState() => _QuizScreenWidgetState();
}

class _QuizScreenWidgetState extends State<QuizScreenWidget> {
  final QuizScreenBloc _quizScreenBloc = QuizScreenBlocImpl();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quizScreenBloc.loadQuestions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuizScreenState>(
        stream: _quizScreenBloc.questionsStream,
        builder: (context, snapshot) {
          if (snapshot.data?.questionsList == null) {
            return StartQuizWidget(
              bloc: _quizScreenBloc,
              nameAccepted: snapshot.data?.nameAccepted ?? true,
            );
          }

          final currentQuestion = snapshot
              .data!.questionsList![_quizScreenBloc.currentQuestionIndex];

          return QuizQuestionWidget(
            question: currentQuestion,
            onAnswerSelected: (answer) =>
                _quizScreenBloc.handleAnswer(answer, context),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _quizScreenBloc.dispose();
    super.dispose();
  }
}
