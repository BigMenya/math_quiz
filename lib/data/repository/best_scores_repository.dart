import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/best_scores_model.dart';

abstract class BestScoresRepository {
  List<BestScoresModel> loadBestScoresList();

  Future<void> saveBestScoresList(BestScoresModel newBestScores);
}

class BestScoresRepositoryImpl implements BestScoresRepository {
  BestScoresRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const String _key = 'bestScoresList';

  @override
  List<BestScoresModel> loadBestScoresList() {
    final jsonString = _prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonDataList = jsonDecode(jsonString);
      final List<BestScoresModel> bestScoresList = jsonDataList
          .map((jsonData) => BestScoresModel.fromJson(jsonData))
          .toList();
      return bestScoresList;
    } else {
      return [];
    }
  }

  @override
  Future<void> saveBestScoresList(BestScoresModel newBestScores) async {
    final loadedBestScoresList = loadBestScoresList();
    loadedBestScoresList.add(newBestScores);

    loadedBestScoresList.sort((a, b) => b.score.compareTo(a.score));
    if (loadedBestScoresList.length > 5) {
      loadedBestScoresList.removeRange(5, loadedBestScoresList.length);
    }

    final jsonDataList =
        loadedBestScoresList.map((bestScores) => bestScores.toJson()).toList();
    final jsonString = jsonEncode(jsonDataList);
    await _prefs.setString(_key, jsonString);
  }
}
