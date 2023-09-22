import 'package:flutter/material.dart';

import '../../../models/best_scores_model.dart';

class TopScoresWidget extends StatelessWidget {
  const TopScoresWidget({super.key, required this.bestScoresList});

  final List<BestScoresModel> bestScoresList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bestScoresList.length,
      itemBuilder: (context, index) {
        final player = bestScoresList[index];
        return ListTile(
          title: Text(player.name),
          subtitle: Text('Score: ${player.score.toString()}'),
        );
      },
    );
  }
}
