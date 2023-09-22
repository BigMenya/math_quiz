import 'package:math_quiz/models/question_model.dart';

enum NavigationState {
  startQuiz,
  questionAnswer,
  summary,
}

class QuizScreenState {
  QuizScreenState({
    this.questionsList,
    this.name,
    this.navigationState,
  });

  final List<QuizQuestionModel>? questionsList;
  final String? name;
  final NavigationState? navigationState;

  QuizScreenState copyWith({
    List<QuizQuestionModel>? questionsList,
    String? name,
    NavigationState? navigationState,
  }) {
    return QuizScreenState(
      questionsList: questionsList ?? this.questionsList,
      name: name ?? this.name,
      navigationState: navigationState ?? this.navigationState,
    );
  }
}
