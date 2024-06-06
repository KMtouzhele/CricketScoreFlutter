
import 'package:crossplatform/domain/repositories/scoring_repository.dart';

class GetTeamInfo extends ScoringRepository {
  final ScoringRepository _repository;
  GetTeamInfo(this._repository);

  @override
  Future<List<Map<String, dynamic>>> getTeamPlayers(String teamId) {
    return _getTeamInfo(teamId);
  }


  Future<List<Map<String, dynamic>>> _getTeamInfo(String teamId) {
    return _repository.getTeamPlayers(teamId);
  }

  @override
  Future<String> getTeamName(String teamId) {
    return _repository.getTeamName(teamId);
  }


}