import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplatform/domain/repositories/update_player_repository.dart';

class UpdatePlayerData implements UpdatePlayerRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> deletePlayer(String playerId) async {
    try {
      await _db.collection('players').doc(playerId).delete();
      print('Successfully deleted player: $playerId');
    } catch (e) {
      print('Failed to delete player: $e');
    }
  }

  @override
  Future<void> updatePlayerName(String playerId, String name) async {
    try {
      await _db.collection('players').doc(playerId).update({'name': name});
      print('Successfully updated player $playerId with new name: $name');
    } catch(e) {
      print('Failed to update player name: $e');
    }
  }

}