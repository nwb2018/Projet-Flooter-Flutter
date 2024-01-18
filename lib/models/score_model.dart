class Score {
  String winner;
  String duration;
  int homeTeamScore;
  int awayTeamScore;

  Score({
    required this.winner,
    required this.duration,
    required this.homeTeamScore,
    required this.awayTeamScore,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      winner: json['winner'] ?? "",
      duration: json['duration'] ?? "",
      homeTeamScore: json['fullTime']['home'] ?? 0,
      awayTeamScore: json['fullTime']['away'] ?? 0,
    );
  }
}