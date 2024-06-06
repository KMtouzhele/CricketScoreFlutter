import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplatform/domain/repositories/individual_repository.dart';

class FetchBallData implements IndividualRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<List<Map<String, dynamic>>> getBallsByMatch(String matchId) async {
    List<Map<String, dynamic>> balls = [];
    try {
      QuerySnapshot snapshot = await _db.collection('balls').where('matchId', isEqualTo: matchId).get();
      for (var doc in snapshot.docs) {
        balls.add(doc.data() as Map<String, dynamic>);
        print('Got ball: ${doc.id}');
      }
      return balls;
    } catch(e) {
      print('Error getting balls: $e');
      return balls;
    }

  }

  @override
  Future<String> getPlayerName(String playerId) async {
    try {
      DocumentSnapshot doc = await _db.collection('players').doc(playerId).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print('Got player: $playerId name: ${data['name']}');
      return data['name'];
    } catch(e) {
      print('Error getting player name: $e');
      return "";
    }
  }

}