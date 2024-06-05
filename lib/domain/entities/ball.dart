class Ball {
  late String id;
  String matchId;
  String strikerId;
  String nonStrikerId;
  String bowlerId;
  BallType ballType;
  int runs;
  int extraRuns;
  bool isBallDelivered;
  DateTime timestamp;

  Ball ({
    required this.matchId,
    required this.strikerId,
    required this.nonStrikerId,
    required this.bowlerId,
    required this.ballType,
    required this.runs,
    required this.extraRuns,
    required this.isBallDelivered,
    required this.timestamp,
  });

  int individualRuns(){
    switch(ballType){
      case BallType.runs: return runs;
      case BallType.fourBoundaries: return 4;
      case BallType.sixBoundaries: return 6;
      default: return 0;
    }
  }

  int teamRuns(){
    switch(ballType){
      case BallType.wide: return 1;
      case BallType.noBall: return 1;
      default: return 0;
    }
  }

  bool isWicket(){
    switch(ballType){
      case BallType.bowled: return true;
      case BallType.caught: return true;
      case BallType.runOut: return true;
      case BallType.stumped: return true;
      case BallType.lbw: return true;
      case BallType.hitWicket: return true;
      case BallType.caughtBowled: return true;
      default: return false;
    }
  }

  bool isExtra(){
    switch(ballType){
      case BallType.wide: return true;
      case BallType.noBall: return true;
      default: return false;
    }
  }

  Map<String, dynamic> toJson(){
    return {
      'matchId': matchId,
      'strikerId': strikerId,
      'nonStrikerId': nonStrikerId,
      'bowlerId': bowlerId,
      'ballType': ballType.toString().split('.').last,
      'runs': runs,
      'extraRuns': extraRuns,
      'isBallDelivered': isBallDelivered,
      'timestamp': timestamp.toIso8601String()
    };
  }
}

enum BallType {
  runs,
  fourBoundaries,
  sixBoundaries,
  noBall,
  wide,
  bowled,
  caught,
  runOut,
  stumped,
  lbw,
  hitWicket,
  caughtBowled
}