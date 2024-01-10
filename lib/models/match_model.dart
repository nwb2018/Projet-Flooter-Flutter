import 'dart:convert';

import 'package:flooter/models/competition_model.dart';
import 'package:flooter/models/score_model.dart';
import 'team_model.dart';

List<Match> matchesFromJson(String str) {
  final jsonData = json.decode(str);
  final List<dynamic> matchesJson = jsonData["matches"];

  return matchesJson.map((json) => Match.fromJson(json)).toList();
}

class Match {
  final Map<String, dynamic> area;
  final CompetitionModel competition;
  final Map<String, dynamic> season;
  final int id;
  final String utcDate;
  final String status;
  final String minute;
  final Score score;
  final Team homeTeam;
  final Team awayTeam;

  Match({
    required this.area,
    required this.competition,
    required this.season,
    required this.id,
    required this.utcDate,
    required this.status,
    required this.minute,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      area: json['area'] ?? {},
      competition: CompetitionModel.fromJson(json['competition'] ?? {}),
      season: json['season'] ?? {},
      id: json['id'] ?? 0,
      utcDate: json['utcDate'] ?? "",
      status: json['status'] ?? "",
      minute: json['minute'] ?? "",
      score: Score.fromJson(json['score'] ?? {}),
      homeTeam: Team.fromJson(json['homeTeam'] ?? {}),
      awayTeam: Team.fromJson(json['awayTeam'] ?? {}),
    );
  }
}
