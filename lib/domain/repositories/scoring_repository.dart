
abstract class ScoringRepository {
  Future<List<Map<String, dynamic>>> getTeamInfo(String teamId);
}