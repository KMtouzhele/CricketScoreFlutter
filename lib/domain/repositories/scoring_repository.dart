
abstract class ScoringRepository {
  Future<List<Map<String, dynamic>>> getTeamPlayers(String teamId);
  Future<String> getTeamName(String teamId);
}