import 'package:crossplatform/domain/repositories/individual_repository.dart';

class GetIndividualResults {
  final IndividualRepository _repository;
  GetIndividualResults(this._repository);

  Future<List<Map<String, dynamic>>> getBatterIndividual(String matchId) async {
    List<Map<String, dynamic>> ballList = await _repository.getBallsByMatch(matchId);
    Map<String, Map<String, int>> result = {};
    Map<String, String> playerNamesCache = {};

    for (var ball in ballList) {
      String strikerId = ball['strikerId'];
      int runs = ball['runs'];
      int ballsFaced = ball['isBallDelivered'] ? 1 : 0;

      if (!playerNamesCache.containsKey(strikerId)) {
        playerNamesCache[strikerId] = await _repository.getPlayerName(strikerId);
      }
      String playerName = playerNamesCache[strikerId]!;

      if (result.containsKey(playerName)) {
        result[playerName]!['runs'] = result[playerName]!['runs']! + runs;
        result[playerName]!['ballsFaced'] = result[playerName]!['ballsFaced']! + ballsFaced;
      } else {
        result[playerName] = {
          'runs': runs,
          'ballsFaced': ballsFaced
        };
      }
    }

    // Convert result map to list
    List<Map<String, dynamic>> resultList = result.entries.map((entry) {
      return {
        'name': entry.key,
        'runs': entry.value['runs'] ?? 0,
        'ballsFaced': entry.value['ballsFaced'] ?? 0,
      };
    }).toList();

    return resultList;
  }

  Future<List<Map<String, dynamic>>> getBowlerIndividual(String matchId) async {
    List<Map<String, dynamic>> ballList = await _repository.getBallsByMatch(matchId);
    Map<String, Map<String, int>> result = {};
    Map<String, String> playerNamesCache = {};

    for (var ball in ballList) {
      String bowlerId = ball['bowlerId'];
      int runsLost = ball['runs'];
      int ballsDelivered = ball['isBallDelivered'] ? 1 : 0;
      int isWicket = _getIsWicket(ball['ballType']);

      if (!playerNamesCache.containsKey(bowlerId)) {
        playerNamesCache[bowlerId] = await _repository.getPlayerName(bowlerId);
      }
      String playerName = playerNamesCache[bowlerId]!;

      if (result.containsKey(playerName)) {
        result[playerName]!['runsLost'] = result[playerName]!['runsLost']! + runsLost;
        result[playerName]!['wickets'] = result[playerName]!['wickets']! + isWicket;
        result[playerName]!['ballsDelivered'] = result[playerName]!['ballsDelivered']! + ballsDelivered;
      } else {
        result[playerName] = {
          'runsLost': runsLost,
          'wickets': isWicket,
          'ballsDelivered': ballsDelivered
        };
      }
    }

    // Convert result map to list
    List<Map<String, dynamic>> resultList = result.entries.map((entry) {
      return {
        'name': entry.key,
        'runsLost': entry.value['runsLost'] ?? 0,
        'wickets': entry.value['wickets'] ?? 0,
        'ballsDelivered': entry.value['ballsDelivered'] ?? 0,
      };
    }).toList();

    return resultList;
  }

  int _getIsWicket(String ballType) {
    switch (ballType) {
      case 'bowled':
      case 'caught':
      case 'runOut':
      case 'stumped':
      case 'lbw':
      case 'hitWicket':
      case 'caughtBowled':
        return 1;
      default:
        return 0;
    }
  }
}
