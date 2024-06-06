abstract class IndividualRepository {
  Future<List<Map<String, dynamic>>> getBallsByMatch(String matchId);
  Future<String> getPlayerName(String playerId);
}