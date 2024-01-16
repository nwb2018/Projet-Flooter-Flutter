import 'dart:convert';

import 'package:flooter/models/competition_model.dart';
import 'package:flooter/models/score_model.dart';
import 'team_model.dart';

List<Match> matchesFromJson(String str) {
  final jsonData = json.decode(str);
  final List<dynamic> matchesJson = jsonData["matches"];
  //  print(matchesJson);
  return matchesJson.map((json) => Match.fromJson(json)).toList();
}

class Match {
  int id;
  String utcDate;
  String area;
  String status;
  int matchday;
  String stage;
  Score score;
  Team homeTeam;
  Team awayTeam;
  String competitionEmblem; // Add this line
  String competitionName; // Add this line
  int competitionId; // Add this line

  Match(
      {required this.id,
      required this.utcDate,
      required this.area,
      required this.status,
      required this.matchday,
      required this.stage,
      required this.score,
      required this.homeTeam,
      required this.awayTeam,
      required this.competitionEmblem, // Add this line
      required this.competitionId, // Add this line
      required this.competitionName}); // Add this line  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      utcDate: json['utcDate'],
      area: json['area']['name'],
      competitionEmblem: json['competition']['emblem'],
      competitionName: json['competition']['name'],
      competitionId: json['competition']['id'],
      status: json['status'],
      matchday: json['matchday'],
      stage: json['stage'],
      score: Score.fromJson(json['score']),
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
    );
  }
}
