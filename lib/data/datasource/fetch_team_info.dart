
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplatform/domain/repositories/scoring_repository.dart';

class FetchTeamInfo implements ScoringRepository {
  //TODO https://chatgpt.com/share/8c666eca-5f79-43ad-bc6b-c8b55cee4685
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<List<Map<String, dynamic>>> getTeamPlayers(String teamId) async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('players')
          .where('teamId', isEqualTo: teamId)
          .get();
      List<Map<String, dynamic>> teamInfo = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      return teamInfo;

    } catch (e) {
      print('Failed to get team info: $e');
      return [];
    }
  }

  @override
  Future<String> getTeamName(String teamId) async {
    try {
      DocumentSnapshot doc = await _db.collection('teams').doc(teamId).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data['teamName'];
    } catch (e) {
      print('Failed to get team name: $e');
      return "";
    }
  }
}