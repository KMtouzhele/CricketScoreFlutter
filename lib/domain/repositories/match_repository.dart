import 'package:crossplatform/domain/entities/player.dart';

abstract class MatchRepository {
  Future<String> addPlayer(Player player);
}

