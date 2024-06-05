import 'package:crossplatform/domain/entities/player.dart';

import '../entities/ball.dart';

abstract class AddBallRepository {
  Future<void> addBall(Ball ball);
  Future<void> updatePlayerStatus(String playerId, PlayerStatus status);
}