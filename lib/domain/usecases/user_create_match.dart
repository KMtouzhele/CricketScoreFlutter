import 'package:crossplatform/domain/repositories/match_repository.dart';
import '../entities/player.dart';
import '../entities/team.dart';
import '../entities/match.dart';

class UserCreateMatch {
  final MatchRepository _repository;
  UserCreateMatch(this._repository);

  Future<Map<String, String>> createMatch(
      String battingTeamName,
      String bowlingTeamName,
      Map<String, int> battersMap,
      Map<String, int> bowlersMap,
      ) async {
    //Assemble teams
    Team battingTeam = Team(teamName: battingTeamName, teamType: TeamType.batting);
    Team bowlingTeam = Team(teamName: bowlingTeamName, teamType: TeamType.bowling);
    //Save teams
    String battingTeamId = await addTeam(battingTeam);
    String bowlingTeamId = await addTeam(bowlingTeam);

    //Assemble players
    List<Player> batters = [];
    List<Player> bowlers = [];
    battersMap.forEach((name, position) {
      batters.add(Player(
          name: name,
          status: PlayerStatus.available,
          position: position,
          teamId: battingTeamId
      ));
    });
    bowlersMap.forEach((name, position) {
      bowlers.add(Player(
          name: name,
          status: PlayerStatus.available,
          position: position,
          teamId: bowlingTeamId
      ));
    });
    //Save players
    for (var batter in batters) {
      String _ = await addPlayer(batter);
    }
    for (var bowler in bowlers) {
      String _ = await addPlayer(bowler);
    }

    //Assemble match
    Match match = Match(
        battingTeamId: battingTeamId,
        bowlingTeamId: bowlingTeamId,
    );
    //Save match
    String matchId = await addMatch(match);

    Map<String, String> matchInfo = {
      'MatchId': matchId,
      'BattingTeamId': battingTeamId,
      'BowlingTeamId': bowlingTeamId,
    };
    return matchInfo;
  }

  Future<String> addTeam(Team team) {
    return _repository.addTeam(team);
  }

  Future<String> addPlayer(Player player) {
    return _repository.addPlayer(player);
  }

  Future<String> addMatch(Match match) {
    return _repository.addMatch(match);
  }
}