

class Player {
  late String id;
  String name;
  PlayerStatus status;
  int position;

  Player({
    required this.name,
    required this.status,
    required this.position,
  });
}

enum PlayerStatus {
  available,
  playing,
  dismissed
}