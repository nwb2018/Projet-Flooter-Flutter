class AreaModel {
  AreaModel({
    required this.id,
    required this.name,
    required this.code,
    this.flag,
  });

  int id;
  String name;
  String code;
  dynamic flag;

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      flag: json["flag"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "flag": flag,
  };
}