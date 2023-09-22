import 'package:flutter/material.dart';

import '../../../models/best_scores_model.dart';

class TopScoresWidget extends StatelessWidget {
  const TopScoresWidget({super.key, required this.bestScoresList});

  final List<BestScoresModel> bestScoresList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bestScoresList.length,
      itemBuilder: (context, index) {
        final player = bestScoresList[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              player.name,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 32),
            Text(
              'Score: ${player.score.toString()}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        );
      },
    );
  }
}
