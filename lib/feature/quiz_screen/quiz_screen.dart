import 'package:flutter/material.dart';
import 'package:math_quiz/feature/quiz_screen/bloc/quiz_screen_bloc.dart';
import 'package:math_quiz/feature/quiz_screen/widgets/quiz_question_widget.dart';
import 'package:math_quiz/feature/quiz_screen/widgets/start_quiz_widget.dart';
import 'package:math_quiz/models/quiz_screen_state.dart';

import '../../constants/constants.dart';

class QuizScreenWidget extends StatefulWidget {
  const QuizScreenWidget({
    super.key,
    required this.bloc,
  });

  final QuizScreenBloc bloc;

  @override
  State<QuizScreenWidget> createState() => _QuizScreenWidgetState();
}

class _QuizScreenWidgetState extends State<QuizScreenWidget> {
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.bloc.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuizScreenState>(
        stream: widget.bloc.questionsStream,
        builder: (context, snapshot) {
          if (snapshot.data?.questionsList == null) {
            return StartQuizWidget(
              bloc: widget.bloc,
              nameCorrect: snapshot.data?.name?.isNotEmpty ?? false,
            );
          }

          final currentQuestion =
              snapshot.data!.questionsList![widget.bloc.currentQuestionIndex];

          return QuizQuestionWidget(
              question: currentQuestion,
              onAnswerSelected: (answer) async {
                await widget.bloc.handleAnswer(answer);
                if (widget.bloc.isLastQuestion) {
                  await widget.bloc.saveScore();
                  pushNextScreen();
                }
              });
        },
      ),
    );
  }

  void pushNextScreen() {
    Navigator.pushNamed(context, Constants.summaryRoute,
        arguments: widget.bloc.score);
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
