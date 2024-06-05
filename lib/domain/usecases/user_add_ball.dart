import 'package:crossplatform/domain/repositories/add_ball_repository.dart';

import '../entities/ball.dart';

class UserAddBall {
  final AddBallRepository _repository;
  UserAddBall(this._repository);

  void addBall(
      String matchId,
      String strikerId,
      String nonStrikerId,
      String bowlerId,
      Map<String, bool> buttonStates,
      ){
    int runs = 0;
    int extraRuns = 0;
    BallType ballType = BallType.runs;
    bool isBallDelivered = true;
    buttonStates.forEach((button, status) {
      if(status == true) {
        switch(button){
          case '1': runs = 1;
          break;
          case '2': runs = 2;
          break;
          case '3': runs = 3;
          break;
          case '4': runs = 4;
          break;
          case '5': runs = 5;
          break;
          case '6': runs = 6;
          break;
          case '7': runs = 7;
          break;
          case '8': runs = 8;
          break;
          case '4S': runs = 4;
          ballType = BallType.fourBoundaries;
          break;
          case '6S': runs = 6;
          ballType = BallType.sixBoundaries;
          break;
          case 'NB': extraRuns = 1;
          ballType = BallType.noBall;
          isBallDelivered = false;
          break;
          case 'WD': extraRuns = 1;
          ballType = BallType.wide;
          isBallDelivered = false;
          break;
          case 'B': ballType = BallType.bowled;
          break;
          case 'C': ballType = BallType.caught;
          break;
          case 'RO': ballType = BallType.runOut;
          break;
          case 'S': ballType = BallType.stumped;
          break;
          case 'LBW': ballType = BallType.lbw;
          break;
          case 'HW': ballType = BallType.hitWicket;
          break;
          case 'CB': ballType = BallType.caughtBowled;
          break;
        }
      }
    });

    Ball ball = Ball(
      matchId: matchId,
      strikerId: strikerId,
      nonStrikerId: nonStrikerId,
      bowlerId: bowlerId,
      ballType: ballType,
      runs: runs,
      extraRuns: extraRuns,
      isBallDelivered: isBallDelivered,
      timestamp: DateTime.now(),
    );

    _repository.addBall(ball);
  }

}