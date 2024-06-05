import '../entities/ball.dart';

abstract class AddBallRepository {
  Future<void> addBall(Ball ball);
}