
import 'package:crossplatform/domain/repositories/update_player_repository.dart';
import 'package:crossplatform/presentation/models/players_model.dart';

class UserSettings{
  final PlayersModel playersModel;
  final UpdatePlayerRepository _repository;
  UserSettings(this._repository, this.playersModel);

  void deletePlayer(String playerId) {
    _repository.deletePlayer(playerId);
    playersModel.removePlayer(playerId);
  }


  void updatePlayerName(String playerId, String name) {
    _repository.updatePlayerName(playerId, name);
    playersModel.modifyName(playerId, name);
  }

}