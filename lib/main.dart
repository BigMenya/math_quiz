import 'package:flutter/material.dart';
import 'package:math_quiz/feature/quiz_screen/quiz_screen.dart';
import 'package:math_quiz/feature/summary_screen/summary_screen.dart';

import 'constants/constants.dart';
import 'feature/welcome_screen/welcome_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        Constants.welcomeRoute: (_) => const WelcomeScreenWidget(),
        Constants.quizScreenRoute: (_) => const QuizScreenWidget(),
        Constants.summaryRoute: (_) => const SummaryScreenWidget(),
      },
    );
  }
}
