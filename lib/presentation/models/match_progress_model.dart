
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


  void swap(){
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

  void update() {
    notifyListeners();
  }

}