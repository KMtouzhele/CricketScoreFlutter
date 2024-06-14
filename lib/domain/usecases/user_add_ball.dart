import 'package:crossplatform/domain/repositories/add_ball_repository.dart';
import 'package:crossplatform/presentation/models/match_progress_model.dart';

import '../../presentation/models/players_model.dart';
import '../entities/ball.dart';
import '../entities/player.dart';

class UserAddBall {
  final AddBallRepository _repository;
  final MatchProgressModel matchProgressModel;
  final PlayersModel playersModel;
  UserAddBall(this._repository, this.matchProgressModel, this.playersModel);

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
          case '0': runs = 0;
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
          case 'ST': ballType = BallType.stumped;
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
    _repository.updatePlayerStatus(strikerId, PlayerStatus.playing);
    _repository.updatePlayerStatus(nonStrikerId, PlayerStatus.playing);
    _repository.updatePlayerStatus(bowlerId, PlayerStatus.playing);

    _updatePlayerStatusInModel(strikerId, PlayerStatus.playing);
    _updatePlayerStatusInModel(nonStrikerId, PlayerStatus.playing);
    _updatePlayerStatusInModel(bowlerId, PlayerStatus.playing);

    if (ball.isWicket()) {
      _repository.updatePlayerStatus(strikerId, PlayerStatus.dismissed);
      _updatePlayerStatusInModel(strikerId, PlayerStatus.dismissed);
    }

    if (matchProgressModel.get()['currentBall'] == 5 && ball.isBallDelivered == true) {
      _repository.updatePlayerStatus(bowlerId, PlayerStatus.dismissed);
      _updatePlayerStatusInModel(bowlerId, PlayerStatus.dismissed);
    }
  }

  void updateScoreBoard(Map<String, bool> buttonStates){
    matchProgressModel.addBall(buttonStates);
  }

  bool isMatchEnded(){
    if (matchProgressModel.get()['currentOver'] == 5) {
      return true;
    }
    if (playersModel.getBatters()
        .where((player) => player['status'] != 'dismissed')
        .length == 2) {
      return true;
    }
    return false;
  }

  void _updatePlayerStatusInModel(String playerId, PlayerStatus status){
    playersModel.modifyStatus(playerId, status);
  }

}