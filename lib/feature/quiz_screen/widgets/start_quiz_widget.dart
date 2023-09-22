import 'package:flutter/material.dart';
import 'package:math_quiz/feature/quiz_screen/bloc/quiz_screen_bloc.dart';

class StartQuizWidget extends StatefulWidget {
  const StartQuizWidget({
    super.key,
    required this.bloc,
    required this.nameAccepted,
  });

  final QuizScreenBloc bloc;
  final bool nameAccepted;

  @override
  State<StartQuizWidget> createState() => _StartQuizWidgetState();
}

class _StartQuizWidgetState extends State<StartQuizWidget> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!widget.nameAccepted)
          const Text(
            'Please insert at least one character',
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter you name and press "Start quiz"',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () =>
              widget.bloc.onStartQuizPressed(nameController.text.isNotEmpty),
          child: const Text('Start quiz'),
        ),
      ],
    );
  }
}
