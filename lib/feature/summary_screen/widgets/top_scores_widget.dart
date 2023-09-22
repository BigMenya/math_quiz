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
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  player.name,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              Expanded(
                child: Text(
                  'Score: ${player.score.toString()}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
