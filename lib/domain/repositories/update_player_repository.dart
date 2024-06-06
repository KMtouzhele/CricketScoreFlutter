abstract class UpdatePlayerRepository {
  Future<void> updatePlayerName(String playerId, String name);
  Future<void> deletePlayer(String playerId);
}