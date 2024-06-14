import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplatform/domain/repositories/match_history_repository.dart';

class FetchMatchHistory implements MatchHistoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<List<Map<String, dynamic>>> getMatchHistory() async {
    try {
      QuerySnapshot snapshot = await _db.collection('matches').get();
      List<Map<String, dynamic>> matches = [];
      //get match data with its document id
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['matchId'] = doc.id;
        matches.add(data);
      }
      return matches;
    } catch (e) {
      print('Error getting match history: $e');
      return [];
    }
  }
}
