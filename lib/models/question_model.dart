class QuizQuestionModel {
  final String question;
  final List<Map<String, dynamic>> options;
  final String correctAnswer;

  QuizQuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      question: json['question'],
      options: List<Map<String, dynamic>>.from(json['options']),
      correctAnswer: json['correctAnswer'],
    );
  }
}
