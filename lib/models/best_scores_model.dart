class BestScoresModel {
  String name;
  int score;

  BestScoresModel(this.name, this.score);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
    };
  }

  static BestScoresModel fromJson(Map<String, dynamic> json) {
    final String name = json['name'];
    final int score = json['score'];

    return BestScoresModel(name, score);
  }
}