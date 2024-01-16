import 'dart:convert';

import 'package:flooter/models/area_model.dart';

List<CompetitionModel> competitionModelFromJson(String str) {
  final jsonData = json.decode(str);
  final List<dynamic> competitionsJson = jsonData["competitions"];

  final List<String> desiredCompetitionNames = [
    "Africa Cup",
    "Bundesliga",
    "Premier League",
    "UEFA Europa League",
    "UEFA Champions League",
    "Ligue 1",
  ];

  return competitionsJson
      .where((json) => desiredCompetitionNames.contains(json["name"]))
      .map((json) => CompetitionModel.fromJson(json))
      .toList();
}

String competitionModelToJson(List<CompetitionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompetitionModel {
  CompetitionModel({
    required this.id,
    required this.name,
    required this.code,
    required this.emblem,
    required this.type,
    required this.area, // Added "area" property
  });

  int id;
  String name;
  String code;
  String emblem;
  String type;
  AreaModel area; // Added "area" property

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      emblem: json["emblem"] ?? "",
      type: json["type"] ?? "",
      area: AreaModel.fromJson(json["area"]), // Added "area" property
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "emblem": emblem,
        "type": type,
        "area": area.toJson(), // Added "area" property
      };
}
