import 'package:flutter/material.dart';

import '../../../models/question_model.dart';

class QuizQuestionWidget extends StatelessWidget {
  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  final QuizQuestionModel question;
  final Function(String) onAnswerSelected;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          question.question,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        Column(
          children: question.options.map((option) {
            final optionText = option.keys.first;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  onAnswerSelected(optionText);
                },
                child: Text(optionText),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}