import 'package:flutter/material.dart';
import 'package:math_quiz/feature/summary_screen/bloc/summary_screen_bloc.dart';
import 'package:math_quiz/feature/summary_screen/widgets/top_scores_widget.dart';

class SummaryScreenWidget extends StatelessWidget {
  const SummaryScreenWidget({
    super.key,
    required this.score,
    required this.bloc,
  });

  final int score;
  final SummaryScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<SummaryScreenState>(
          stream: bloc.summaryScreenState,
          builder: (context, snapshot) {
            final state = snapshot.data ?? SummaryScreenState.yourScore;
            return state == SummaryScreenState.yourScore ?  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Score:',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  '$score',
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: bloc.onLookTopScoresPressed,
                  child: const Text('Look top 5 scores'),
                )
              ],
            ) : TopScoresWidget(bestScoresList: [],);
          },
        ),
      ),
    );
  }


}
