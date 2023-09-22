import 'dart:async';

import '../../../data/repository/best_scores_repository.dart';
import '../../../models/best_scores_model.dart';

enum SummaryScreenState {
  yourScore,
  topPlayers,
}

abstract class SummaryScreenBloc {
  void onLookTopScoresPressed();

  Stream<SummaryScreenState> get summaryScreenState;

  List<BestScoresModel> fetchBestScores();

  void dispose();
}

class SummaryScreenBlocImpl implements SummaryScreenBloc {
  SummaryScreenBlocImpl(this._bestScoresRepository);

  final BestScoresRepository _bestScoresRepository;
  final StreamController<SummaryScreenState> _stateController =
      StreamController<SummaryScreenState>();

  @override
  void onLookTopScoresPressed() {
    _stateController.add(SummaryScreenState.topPlayers);
  }

  @override
  Stream<SummaryScreenState> get summaryScreenState => _stateController.stream;

  @override
  void dispose() {
    _stateController.close();
  }

  @override
  List<BestScoresModel> fetchBestScores() =>
      _bestScoresRepository.loadBestScoresList();
}
