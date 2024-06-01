import 'package:crossplatform/domain/repositories/match_repository.dart';
import '../entities/player.dart';
import '../entities/team.dart';

class UserAddPlayer {
  final MatchRepository _repository;
  UserAddPlayer(this._repository);

  Map<String, String> createMatch() {
    Map<String, String> result = {};
    return result;
  }

  Future<String> addBattingTeam(Team team) {
    return _repository.addTeam(team);
  }

  Future<String> addBowlingTeam(Team team) {
    return _repository.addTeam(team);
  }

  Future<String> addPlayer(Player player) {
    return _repository.addPlayer(player);
  }
}