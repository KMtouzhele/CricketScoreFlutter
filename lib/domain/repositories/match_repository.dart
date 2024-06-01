import '../entities/player.dart';
import '../entities/team.dart';
import '../entities/match.dart';

abstract class MatchRepository {
  Future<String> addPlayer(Player player);
  Future<String> addTeam(Team team);
  Future<String> addMatch(Match match);
}

