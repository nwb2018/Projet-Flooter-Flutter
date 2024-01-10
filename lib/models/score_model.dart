class Score {
  final String winner;
  final String duration;

  Score({
    required this.winner,
    required this.duration,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      winner: json['winner'],
      duration: json['duration'],
    );
  }
}