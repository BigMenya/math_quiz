import 'package:math_quiz/models/question_model.dart';

class QuizScreenState {
  QuizScreenState({
    this.questionsList,
    this.name,
    this.finishQuiz = false,
  });

  final List<QuizQuestionModel>? questionsList;
  final String? name;
  final bool finishQuiz;

  QuizScreenState copyWith({
    List<QuizQuestionModel>? questionsList,
    String? name,
    bool? finishQuiz,
  }) {
    return QuizScreenState(
      questionsList: questionsList ?? this.questionsList,
      name: name ?? this.name,
      finishQuiz: finishQuiz ?? this.finishQuiz,
    );
  }
}
