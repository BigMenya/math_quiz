import 'package:math_quiz/models/question_model.dart';

class QuizScreenState {
  QuizScreenState({
    this.questionsList,
    this.nameAccepted,
  });

  final List<QuizQuestionModel>? questionsList;
  final bool? nameAccepted;

  QuizScreenState copyWith({
    List<QuizQuestionModel>? questionsList,
    bool? nameAccepted,
  }) {
    return QuizScreenState(
      questionsList: questionsList ?? this.questionsList,
      nameAccepted: nameAccepted ?? this.nameAccepted,
    );
  }
}
