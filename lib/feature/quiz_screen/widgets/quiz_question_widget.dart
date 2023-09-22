import 'package:flutter/material.dart';

import '../../../models/question_model.dart';

class QuizQuestionWidget extends StatelessWidget {
  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.progressStream,
  });

  final QuizQuestionModel question;
  final Function(String) onAnswerSelected;
  final Stream<double> progressStream;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<double>(
              stream: progressStream,
              builder: (context, snapshot) {
                return LinearProgressIndicator(value: snapshot.data ?? 0.0);
              }),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            question.question,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: question.options.map((option) {
            final optionText = option.values.first;
            final optionKey = option.keys.first;
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  onPressed: () {
                    onAnswerSelected(optionKey);
                  },
                  child: Text(
                    optionText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
