

class Player {
  late String id;
  String name;
  PlayerStatus status;
  int position;
  String teamId;

  Player({
    required this.name,
    required this.status,
    required this.position,
    required this.teamId,
  });

  Player.fromJson(Map<String, dynamic> json, this.id):
        name = json['name'],
        status = json['status']
        == 'available' ? PlayerStatus.available : json['status']
        == 'playing' ? PlayerStatus.playing : PlayerStatus.dismissed,
        position = json['position'],
        teamId = json['teamId']
  ;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status.toString().split('.').last,
      'position': position,
      'teamId': teamId,
    };
  }
}

enum PlayerStatus {
  available,
  playing,
  dismissed
}