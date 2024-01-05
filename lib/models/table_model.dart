import 'dart:convert';

import 'package:flooter/models/team_model.dart';

class TableItem {
  final int position;
  final Team team;
  final int playedGames;
  final String form;
  final int won;
  final int draw;
  final int lost;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;

  TableItem({
    required this.position,
    required this.team,
    required this.playedGames,
    required this.form,
    required this.won,
    required this.draw,
    required this.lost,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
  });

  factory TableItem.fromJson(Map<String, dynamic> json) {
    return TableItem(
      position: json['position'] ?? 0,
      team: Team.fromJson(json['team'] ?? {}),
      playedGames: json['playedGames'] ?? 0,
      form: json['form'] ?? "",
      won: json['won'] ?? 0,
      draw: json['draw'] ?? 0,
      lost: json['lost'] ?? 0,
      points: json['points'] ?? 0,
      goalsFor: json['goalsFor'] ?? 0,
      goalsAgainst: json['goalsAgainst'] ?? 0,
      goalDifference: json['goalDifference'] ?? 0,
    );
  }

  static List<TableItem> tableItemsFromJson(String str) {
    final jsonData = json.decode(str);
    final List<dynamic> standingsJson = jsonData["standings"][0]["table"];

    return standingsJson.map((json) => TableItem.fromJson(json)).toList();
  }
}
