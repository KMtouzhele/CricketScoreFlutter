
import 'package:flutter/cupertino.dart';

class MatchProgressModel extends ChangeNotifier {
  Map<String, dynamic> matchProgress = {
    "currentBall": 0,
    "currentOver": 0,
    "totalRuns": 0,
    "totalWickets": 0,
    "totalBallDelivered": 0,
    "totalExtras": 0,
    "currentStrikerId": "",
    "currentNonStrikerId": "",
    "currentBowlerId": "",
    "strikerRuns": 0,
    "strikerBalls": 0,
    "strikerFours": 0,
    "strikerSixes": 0,
    "nonStrikerRuns": 0,
    "nonStrikerBalls": 0,
    "nonStrikerFours": 0,
    "nonStrikerSixes": 0,
    "bowlerWickets": 0,
    "bowlerBalls": 0,
    "bowlerRunsLost": 0
  };

  Map<String, dynamic> init(){
    matchProgress = {
      "currentBall": 0,
      "currentOver": 0,
      "totalRuns": 0,
      "totalWickets": 0,
      "totalBallDelivered": 0,
      "totalExtras": 0,
      "currentStrikerId": "",
      "currentNonStrikerId": "",
      "currentBowlerId": "",
      "strikerRuns": 0,
      "strikerBalls": 0,
      "strikerFours": 0,
      "strikerSixes": 0,
      "nonStrikerRuns": 0,
      "nonStrikerBalls": 0,
      "nonStrikerFours": 0,
      "nonStrikerSixes": 0,
      "bowlerWickets": 0,
      "bowlerBalls": 0,
      "bowlerRunsLost": 0
    };
    update();
    return matchProgress;
  }

  Map<String, dynamic> get(){
    return matchProgress;
  }

  void changeStriker(String strikerId){
    matchProgress["currentStrikerId"] = strikerId;
    update();
  }

  void changeNonStriker(String nonStrikerId){
    matchProgress["currentNonStrikerId"] = nonStrikerId;
    update();
  }

  void changeBowler(String bowlerId){
    matchProgress["currentBowlerId"] = bowlerId;
    update();
  }

  void addBall(Map<String, bool> buttonStates){
    bool isBallDelivered = _isBallDelivered(buttonStates);
    int runs = _calculateNewRuns(buttonStates);
    int extraRuns = _calculateExtraRuns(buttonStates);
    matchProgress['totalRuns'] += runs + extraRuns;

    bool isWicket = _isWicket(buttonStates);
    matchProgress['totalWickets'] += isWicket ? 1 : 0;

    matchProgress['totalBallDelivered'] += isBallDelivered ? 1 : 0;
    matchProgress['totalExtras'] += isBallDelivered ? 0 : 1;

    matchProgress['strikerRuns'] += runs;
    matchProgress['strikerBalls'] += isBallDelivered ? 1 : 0;
    matchProgress['strikerFours'] += buttonStates['4S'] == true ? 1 : 0;
    matchProgress['strikerSixes'] += buttonStates['6S'] == true ? 1 : 0;

    matchProgress['bowlerWickets'] += isWicket ? 1 : 0;
    matchProgress['bowlerBalls'] += isBallDelivered ? 1 : 0;
    matchProgress['bowlerRunsLost'] += runs + extraRuns;

    matchProgress["currentBall"] += isBallDelivered ? 1 : 0;
    if (matchProgress["currentBall"] == 6) {
      _bowlerDismissed();
      _swap();
      matchProgress["currentOver"] += 1;
      matchProgress["currentBall"] = 0;
    }

    if (isWicket) {
      _strikerDismissed();
    }

    if (runs % 2 == 1) {
      _swap();
    }


    update();
  }

  int _calculateNewRuns(Map<String, bool> buttonStates){
    int runs = 0;
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
          break;
          case '6S': runs = 6;
          break;
          default: runs = 0;
        }
      }
    });
    return runs;
  }

  int _calculateExtraRuns(Map<String, bool> buttonStates){
    int extraRuns = 0;
    buttonStates.forEach((button, status) {
      if(status == true) {
        switch(button){
          case 'NB': extraRuns = 1;
          break;
          case 'WD': extraRuns = 1;
          break;
          default: extraRuns = 0;
        }
      }
    });
    return extraRuns;
  }

  bool _isBallDelivered(Map<String, bool> buttonStates){
    bool isBallDelivered = true;
    buttonStates.forEach((button, status) {
      if(status == true) {
        switch(button){
          case 'NB': isBallDelivered = false;
          break;
          case 'WD': isBallDelivered = false;
          break;
          default: isBallDelivered = true;
        }
      }
    });
    return isBallDelivered;
  }

  bool _isWicket(Map<String, bool> buttonStates){
    bool isWicket = false;
    buttonStates.forEach((button, status) {
      if(status == true) {
        switch(button){
          case 'B': isWicket = true;
          break;
          case 'C': isWicket = true;
          break;
          case 'RO': isWicket = true;
          break;
          case 'ST': isWicket = true;
          break;
          case 'LBW': isWicket = true;
          break;
          case 'HW': isWicket = true;
          break;
          case 'CB': isWicket = true;
          break;
          default: isWicket = false;
        }
      }
    });
    return isWicket;
  }




  void _swap(){
    Map<String, dynamic> newMatchProgress = {
      "currentBall": matchProgress["currentBall"],
      "currentOver": matchProgress["currentOver"],
      "totalRuns": matchProgress["totalRuns"],
      "totalWickets": matchProgress["totalWickets"],
      "totalBallDelivered": matchProgress["totalBallDelivered"],
      "totalExtras": matchProgress["totalExtras"],
      //swap striker and non striker id
      "currentStrikerId": matchProgress["currentNonStrikerId"],
      "currentNonStrikerId": matchProgress["currentStrikerId"],

      "currentBowlerId": matchProgress["currentBowlerId"],
      //swap striker and non striker data
      "strikerRuns": matchProgress["nonStrikerRuns"],
      "strikerBalls": matchProgress["nonStrikerBalls"],
      "strikerFours": matchProgress["nonStrikerFours"],
      "strikerSixes": matchProgress["nonStrikerSixes"],
      "nonStrikerRuns": matchProgress["strikerRuns"],
      "nonStrikerBalls": matchProgress["strikerBalls"],
      "nonStrikerFours": matchProgress["strikerFours"],
      "nonStrikerSixes": matchProgress["strikerSixes"],

      "bowlerWickets": matchProgress["bowlerWickets"],
      "bowlerBalls": matchProgress["bowlerBalls"],
      "bowlerRunsLost": matchProgress["bowlerRunsLost"]
    };
    matchProgress = newMatchProgress;
    update();
  }

  void _strikerDismissed(){
    matchProgress['currentStrikerId'] = "";
    matchProgress['strikerRuns'] = 0;
    matchProgress['strikerBalls'] = 0;
    matchProgress['strikerFours'] = 0;
    matchProgress['strikerSixes'] = 0;
    update();
  }

  void _bowlerDismissed(){
    matchProgress['currentBowlerId'] = "";
    matchProgress['bowlerWickets'] = 0;
    matchProgress['bowlerBalls'] = 0;
    matchProgress['bowlerRunsLost'] = 0;
  }

  void update() {
    notifyListeners();
  }

}