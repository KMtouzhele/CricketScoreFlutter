import 'package:crossplatform/domain/repositories/individual_repository.dart';
import 'package:crossplatform/domain/repositories/match_history_repository.dart';
import 'package:crossplatform/domain/repositories/scoring_repository.dart';

class GetMatchHistory {
  final MatchHistoryRepository _matchHistoryRepository;
  final ScoringRepository _scoringRepository;
  final IndividualRepository _individualRepository;
  GetMatchHistory(
      this._matchHistoryRepository,
      this._scoringRepository,
      this._individualRepository
      );

  Future<List<Map<String, dynamic>>> getMatchHistory() async{
    List<Map<String, dynamic>> matchInfo = await _matchHistoryRepository.getMatchHistory();
    List<Map<String, dynamic>> matchName = [];
    for (var match in matchInfo) {
      String battingTeamName = await _getTeamName(match['battingTeamId']);
      String bowlingTeamName = await _getTeamName(match['bowlingTeamId']);
      String matchId = match['matchId'];
      matchName.add({
        'matchId': matchId,
        'battingTeamName': battingTeamName,
        'bowlingTeamName': bowlingTeamName,
      });
    }
    return matchName;
  }

  Future<List<Map<String, dynamic>>> getBalls(String matchId) async {
    List<Map<String, dynamic>> balls = await _individualRepository.getBallsByMatch(matchId);
    List<Map<String, dynamic>> ballList = [];
    for (var ball in balls) {
      String strikerName = await _individualRepository.getPlayerName(ball['strikerId']);
      String nonStrikerName = await _individualRepository.getPlayerName(ball['nonStrikerId']);
      String bowlerName = await _individualRepository.getPlayerName(ball['bowlerId']);
      DateTime timeStamp = DateTime.parse(ball['timestamp']);
      ballList.add({
        'strikerName': strikerName,
        'nonStrikerName': nonStrikerName,
        'bowlerName': bowlerName,
        'runs': ball['runs'],
        'ballType': ball['ballType'],
        'timeStamp': timeStamp,
      });
      ballList.sort((a, b) => a['timeStamp'].compareTo(b['timeStamp']));
    }
    return ballList;
  }

  int getMatchTotalRuns(List<Map<String, dynamic>> balls){
    int totalRuns = 0;
    for (var ball in balls) {
      totalRuns += ball['runs']! as int;
    }
    return totalRuns;
  }

  int getMatchTotalWickets(List<Map<String, dynamic>> balls){
    int totalWickets = 0;
    for (var ball in balls) {
      if (ball['ballType'] == 'bowled'
          || ball['ballType'] == 'caught'
          || ball['ballType'] == 'lbw'
          || ball['ballType'] == 'runOut'
          || ball['ballType'] == 'stumped'
          || ball['ballType'] == 'hitWicket'
          || ball['ballType'] == 'caughtBowled'
      ) {
        totalWickets += 1;
      }
    }
    return totalWickets;
  }

  Future<String> _getTeamName(String teamId) async {
    return await _scoringRepository.getTeamName(teamId);
  }
}