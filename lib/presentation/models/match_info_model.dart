
import 'package:flutter/cupertino.dart';

class MatchInfoModel extends ChangeNotifier {
  Map<String, String> matchInfo = {};

  Map<String, String> get(){
    return matchInfo;
  }

  void add(Map<String, String> newMatchInfo) {
    matchInfo = newMatchInfo;
    update();
  }

  void update() {
    notifyListeners();
  }
}