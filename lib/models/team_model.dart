
class Team {
  final int id;
  final String name;
  final String shortName;
  final String crest;

  Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.crest,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      crest: json['crest'],
    );
  }
}