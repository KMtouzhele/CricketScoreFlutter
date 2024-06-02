
import 'package:crossplatform/domain/repositories/scoring_repository.dart';

class GetTeamInfo extends ScoringRepository {
  final ScoringRepository _repository;
  GetTeamInfo(this._repository);

  @override
  Future<List<Map<String, dynamic>>> getTeamInfo(String teamId) {
    return _getTeamInfo(teamId);
  }


  Future<List<Map<String, dynamic>>> _getTeamInfo(String teamId) {
    return _repository.getTeamInfo(teamId);
  }


}