
class Team {
  late String id;
  String teamName;
  TeamType teamType;

  Team({
    required this.teamName,
    required this.teamType,
  });

  Team.fromJson(Map<String, dynamic> json, this.id):
    teamName = json['teamName'],
    teamType = json['teamType'];

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'teamType': teamType.toString().split('.').last,
    };
  }
}

enum TeamType {
  batting,
  bowling
}