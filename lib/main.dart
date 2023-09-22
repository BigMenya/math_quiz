import 'package:flutter/material.dart';
import 'package:math_quiz/data/repository/best_scores_repository.dart';
import 'package:math_quiz/feature/quiz_screen/bloc/quiz_screen_bloc.dart';
import 'package:math_quiz/feature/quiz_screen/quiz_screen.dart';
import 'package:math_quiz/feature/summary_screen/bloc/summary_screen_bloc.dart';
import 'package:math_quiz/feature/summary_screen/summary_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';
import 'feature/welcome_screen/welcome_screen_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final repository = BestScoresRepositoryImpl(prefs);
    return MaterialApp(
      title: 'Math Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        Constants.welcomeRoute: (_) => const WelcomeScreenWidget(),
        Constants.quizScreenRoute: (_) =>
            QuizScreenWidget(bloc: QuizScreenBlocImpl(repository)),
        Constants.summaryRoute: (_) =>
            SummaryScreenWidget(bloc: SummaryScreenBlocImpl(repository)),
      },
    );
  }
}
