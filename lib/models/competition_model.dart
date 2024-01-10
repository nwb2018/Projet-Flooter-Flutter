import 'dart:convert';

List<CompetitionModel> competitionModelFromJson(String str) {
  final jsonData = json.decode(str);
  final List<dynamic> competitionsJson = jsonData["competitions"];

  final List<String> desiredCompetitionNames = [
    "Africa Cup",
    "Bundesliga",
    "Premier League",
    "UEFA Europa League",
    "UEFA Champions League",
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
  });

  int id;
  String name;
  String code;
  String emblem;
  String type;

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      emblem: json["emblem"] ?? "",
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "emblem": emblem,
        "type": type,
      };
}
