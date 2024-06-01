class Match {
  late String id;
  String battingTeamId;
  String bowlingTeamId;

  Match({
    required this.battingTeamId,
    required this.bowlingTeamId,
  });

  Match.fromJson(Map<String, dynamic> json, this.id):
    battingTeamId = json['battingTeam'],
    bowlingTeamId = json['bowlingTeam']
  ;

  Map<String, dynamic> toJson() {
    return {
      'battingTeamId': battingTeamId,
      'bowlingTeamId': bowlingTeamId,
    };
  }
}