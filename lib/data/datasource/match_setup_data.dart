import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/entities/player.dart';
import '../../domain/entities/match.dart';
import '../../domain/entities/team.dart';
import '../../domain/repositories/match_repository.dart';

class MatchSetupData implements MatchRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<String> addPlayer(Player player) async {
    try {
      DocumentReference docRef = await _db.collection('players').add(player.toJson());
      print('Player added successfully with id: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('Failed to add player: $e');
      return '';
    }

  }

  @override
  Future<String> addTeam(Team team) async {
    try {
      print('Trying to save a new team...');
      DocumentReference docRef = await _db.collection('teams').add(team.toJson());
      print('Team added successfully with id: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('Failed to add team: $e');
      return '';
    }

  }

  @override
  Future<String> addMatch(Match match) async {
    try {
      DocumentReference docRef = await _db.collection('matches').add(match.toJson());
      print('Match added successfully with id: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('Failed to add match: $e');
      return '';
    }
  }

}