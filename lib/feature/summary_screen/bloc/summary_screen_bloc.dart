import 'dart:async';

enum SummaryScreenState {
  yourScore,
  topPlayers,
}

abstract class SummaryScreenBloc {
  void onLookTopScoresPressed();

  Stream<SummaryScreenState> get summaryScreenState;

  void dispose();
}

class SummaryScreenBlocImpl implements SummaryScreenBloc {
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
}
