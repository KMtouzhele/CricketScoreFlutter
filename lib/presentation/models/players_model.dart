import 'package:crossplatform/domain/entities/player.dart';
import 'package:flutter/cupertino.dart';


class PlayersModel extends ChangeNotifier {
  List<Map<String, dynamic>> batters = [];
  List<Map<String, dynamic>> bowlers = [];

  List<Map<String, dynamic>> getBatters(){
    return batters;
  }

  List<Map<String, dynamic>> getBowlers(){
    return bowlers;
  }

  void addBatters(List<Map<String, dynamic>> newBatters) {
    batters = newBatters;
    update();
  }
  void addBowlers(List<Map<String, dynamic>> newBowlers) {
    bowlers = newBowlers;
    update();
  }

  void modifyStatus(String playerId, PlayerStatus newStatus){
    for (var batter in batters) {
      if(batter['id'] == playerId){
        batter['status'] = newStatus;
        break;
      }
    }
    for (var bowler in bowlers) {
      if(bowler['id'] == playerId){
        bowler['status'] = newStatus;
        break;
      }
    }
    update();
  }

  void modifyName(String playerId, String newName){
    for (var batter in batters) {
      if(batter['id'] == playerId){
        batter['name'] = newName;
        break;
      }
    }
    for (var bowler in bowlers) {
      if(bowler['id'] == playerId){
        bowler['name'] = newName;
        break;
      }
    }
    update();
  }

  void removePlayer(String playerId){
    batters.removeWhere((element) => element['id'] == playerId);
    bowlers.removeWhere((element) => element['id'] == playerId);
    update();
  }

  void update() {
    notifyListeners();
  }
}