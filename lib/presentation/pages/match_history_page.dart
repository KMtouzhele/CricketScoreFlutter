import 'package:crossplatform/data/datasource/fetch_ball_data.dart';
import 'package:crossplatform/data/datasource/fetch_match_history.dart';
import 'package:crossplatform/data/datasource/fetch_team_info.dart';
import 'package:crossplatform/domain/repositories/match_history_repository.dart';
import 'package:crossplatform/domain/repositories/scoring_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/individual_repository.dart';
import '../../domain/usecases/get_match_history.dart';
import '../common/constants.dart';
import '../common/widgets.dart';
import 'match_history_detail_page.dart';
import 'match_setup_page.dart';

class MatchHistoryPage extends StatefulWidget {
  const MatchHistoryPage({super.key});

  @override
  State<MatchHistoryPage> createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  List<Map<String, dynamic>> matchHistory = [];
  bool isLoading = true;
  final MatchHistoryRepository _matchHistoryRepository = FetchMatchHistory();
  final ScoringRepository _scoringRepository = FetchTeamInfo();
  final IndividualRepository _individualRepository = FetchBallData();
  late final GetMatchHistory _getMatchHistory;

  @override
  void initState(){
    super.initState();
    _getMatchHistory = GetMatchHistory(
        _matchHistoryRepository,
        _scoringRepository,
        _individualRepository
    );
    _getMatchHistoryList();
  }

  void _getMatchHistoryList() async {
    List<Map<String, dynamic>> matchHistoryList = await _getMatchHistory.getMatchHistory();
    setState(() {
      matchHistory = matchHistoryList;
      isLoading = false;
      print('Got ${matchHistory.length} matches');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Match History",
          style: titleStyle,
        ),

      ),
      body: Center(
        child: SafeArea(
            child: Column(
                children: [
                  isLoading ?
                  const Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        CircularProgressIndicator(
                          color: Colors.lightGreenAccent,
                        ),
                        marginSpaceSmall,
                        Text("Loading..."),
                        Spacer(),
                      ],
                    ),
                  )
                  :
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ListView.builder(
                          itemBuilder: (
                              BuildContext context,
                              int index
                              ) {
                              var match = matchHistory[index];
                              return CustomHistoryObjectWidget(
                                match: match,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MatchHistoryDetailPage(matchId: match['matchId'])),
                                  );
                                },
                              );
                          },
                          itemCount: matchHistory.length,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(borderPadding),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MatchSetupPage()),
                        );
                      },
                      style: primaryButtonStyle,
                      child: const Text("Create Match"),
                    ),
                  ),
                ]
            )
        ),
      ),
    );
  }
}

class CustomHistoryObjectWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomHistoryObjectWidget({
    super.key,
    required this.match,
    required this.onPressed,
  });

  final Map<String, dynamic> match;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Match ID: ${match['matchId']}",
              ),
              marginSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    match['battingTeamName'],
                    style: titleStyle,
                  ),
                  marginSpaceMediumV,
                  const Text("VS"),
                  marginSpaceMediumV,
                  Text(
                    match['bowlingTeamName'],
                    style: titleStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}