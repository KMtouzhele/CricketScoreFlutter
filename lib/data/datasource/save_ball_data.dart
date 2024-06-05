
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossplatform/domain/entities/ball.dart';
import 'package:crossplatform/domain/repositories/add_ball_repository.dart';

class SaveBallData implements AddBallRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<void> addBall(Ball ball) async {
    try {
      await _db.collection('balls').add(ball.toJson());
      print('Successfully added ball.');
    } catch (e) {
      print('Failed to add ball: $e');
    }
  }

}