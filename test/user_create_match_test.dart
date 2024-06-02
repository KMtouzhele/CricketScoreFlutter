
import 'package:crossplatform/domain/entities/player.dart';
import 'package:crossplatform/domain/entities/team.dart';
import 'package:crossplatform/domain/entities/match.dart';
import 'package:crossplatform/domain/repositories/match_repository.dart';
import 'package:crossplatform/domain/usecases/user_create_match.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMatchRepository extends Mock implements MatchRepository {}

void main(){
  late MockMatchRepository mockRepository;
  late UserCreateMatch userCreateMatch;

  setUp( (){
    mockRepository = MockMatchRepository();
    userCreateMatch = UserCreateMatch(mockRepository);
  });

  test('should return a right Map', () {
    const battingTeamName = 'battingTeamName';
    const bowlingTeamName = 'bowlingTeamName';

    when(mockRepository.addTeam(Team(teamName: battingTeamName, teamType: TeamType.batting)))
      .thenAnswer((_) async => 'battingTeamId');
    when(mockRepository.addTeam(Team(teamName: bowlingTeamName, teamType: TeamType.bowling)))
      .thenAnswer((_) async => 'bowlingTeamId');
    when(mockRepository.addPlayer(Player(name: 'batter1', status: PlayerStatus.available, position: 1, teamId: 'battingTeamId')))
      .thenAnswer((_) async => 'batter1Id');
    when(mockRepository.addPlayer(Player(name: 'batter2', status: PlayerStatus.available, position: 2, teamId: 'battingTeamId')))
      .thenAnswer((_) async => 'batter2Id');
    when(mockRepository.addPlayer(Player(name: 'batter3', status: PlayerStatus.available, position: 3, teamId: 'battingTeamId')))
      .thenAnswer((_) async => 'batter3Id');
    when(mockRepository.addPlayer(Player(name: 'batter4', status: PlayerStatus.available, position: 4, teamId: 'battingTeamId')))
      .thenAnswer((_) async => 'batter4Id');
    when(mockRepository.addPlayer(Player(name: 'batter5', status: PlayerStatus.available, position: 5, teamId: 'battingTeamId')))
      .thenAnswer((_) async => 'batter5Id');
    when(mockRepository.addPlayer(Player(name: 'bowler1', status: PlayerStatus.available, position: 1, teamId: 'bowlingTeamId')))
      .thenAnswer((_) async => 'bowler1Id');
    when(mockRepository.addPlayer(Player(name: 'bowler2', status: PlayerStatus.available, position: 2, teamId: 'bowlingTeamId')))
      .thenAnswer((_) async => 'bowler2Id');
    when(mockRepository.addPlayer(Player(name: 'bowler3', status: PlayerStatus.available, position: 3, teamId: 'bowlingTeamId')))
      .thenAnswer((_) async => 'bowler3Id');
    when(mockRepository.addPlayer(Player(name: 'bowler4', status: PlayerStatus.available, position: 4, teamId: 'bowlingTeamId')))
      .thenAnswer((_) async => 'bowler4Id');
    when(mockRepository.addPlayer(Player(name: 'bowler5', status: PlayerStatus.available, position: 5, teamId: 'bowlingTeamId')))
      .thenAnswer((_) async => 'bowler5Id');
    when(mockRepository.addMatch(Match(battingTeamId: 'battingTeamId', bowlingTeamId: 'bowlingTeamId'))).thenAnswer((_) async => 'matchId');

    final result = userCreateMatch.createMatch(
      battingTeamName,
      bowlingTeamName,
      {
        'batter1': 1,
        'batter2': 2,
        'batter3': 3,
        'batter4': 4,
        'batter5': 5,
      },
      {
        'bowler1': 1,
        'bowler2': 2,
        'bowler3': 3,
        'bowler4': 4,
      },
    );

    expect(result, {
      'MatchId': 'matchId',
      'BattingTeamId': 'battingTeamId',
      'BowlingTeamId': 'bowlingTeamId',
    });

  });
}