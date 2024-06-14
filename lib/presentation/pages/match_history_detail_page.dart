import 'dart:convert';

import 'package:crossplatform/data/datasource/fetch_team_info.dart';
import 'package:crossplatform/domain/repositories/individual_repository.dart';
import 'package:crossplatform/domain/repositories/match_history_repository.dart';
import 'package:crossplatform/domain/repositories/scoring_repository.dart';
import 'package:crossplatform/presentation/common/constants.dart';
import 'package:crossplatform/presentation/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../data/datasource/fetch_ball_data.dart';
import '../../data/datasource/fetch_match_history.dart';
import '../../domain/usecases/get_match_history.dart';

class MatchHistoryDetailPage extends StatefulWidget {
  final String matchId;
  const MatchHistoryDetailPage({super.key, required this.matchId});

  @override
  State<MatchHistoryDetailPage> createState() => _MatchHistoryDetailPageState();
}

class _MatchHistoryDetailPageState extends State<MatchHistoryDetailPage> {
  List<Map<String, dynamic>> matchDetailState = [];
  bool isLoading = true;
  final ScoringRepository _scoringRepository = FetchTeamInfo();
  final IndividualRepository _individualRepository = FetchBallData();
  final MatchHistoryRepository _matchHistoryRepository = FetchMatchHistory();
  late final GetMatchHistory _getMatchHistory;

  @override
  void initState() {
    super.initState();
    _getMatchHistory = GetMatchHistory(
      _matchHistoryRepository,
      _scoringRepository,
      _individualRepository
    );
    _getMatchDetail();
  }

  void _getMatchDetail() async {
    List<Map<String, dynamic>> matchDetail = await _getMatchHistory.getBalls(widget.matchId);
    setState(() {
      matchDetailState = matchDetail;
      isLoading = false;
      //print('Got ${matchDetailState.length} balls');
    });
  }

  void _shareJsonText() {
    List<Map<String, dynamic>> jsonList = [];
    for (var ball in matchDetailState) {
      String formattedTimeStamp = ball['timeStamp'].toIso8601String(); // Convert DateTime to ISO 8601 string
      Map<String, dynamic> jsonBall = {
        'strikerName': ball['strikerName'],
        'nonStrikerName': ball['nonStrikerName'],
        'bowlerName': ball['bowlerName'],
        'timeStamp': formattedTimeStamp, // Use the formatted timestamp
        'ballType': ball['ballType'],
        'runs': ball['runs'],
      };
      jsonList.add(jsonBall);
    }
    String jsonString = jsonEncode(jsonList);
    Share.share(
      jsonString,
      subject: 'Match Detail JSON',
    );
  }

  int getMatchTotalRuns(List<Map<String, dynamic>> balls){
    return _getMatchHistory.getMatchTotalRuns(balls);
  }

  int getMatchTotalWickets(List<Map<String, dynamic>> balls){
    return _getMatchHistory.getMatchTotalWickets(balls);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Detail"),
      ),
      body: isLoading ?
      const Center(
        child: Column(
          children: [
            Spacer(),
            CircularProgressIndicator(
              color: Colors.lightGreenAccent,
            ),
            marginSpaceSmall,
            Text("Loading..."),
            Spacer()
          ],
        ),
      ) :
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "WICKETS: ${getMatchTotalWickets(matchDetailState)}",
                    style: subtitleStyle,
                  ),
                  Spacer(),
                  Text(
                    "TOTAL RUNS: ${getMatchTotalRuns(matchDetailState)}",
                    style: subtitleStyle,
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (
                        BuildContext context,
                        int index,
                        ) {
                      var ball = matchDetailState[index];
                      String ballType = "";
                      if (ball['ballType'] == 'sixBoundaries') {
                        ballType = "6S";
                      } else if (ball['ballType'] == 'fourBoundaries') {
                        ballType = "4S";
                      } else {
                        ballType = ball['ballType'].toUpperCase();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.sports_cricket,
                                        color: Colors.purpleAccent,
                                      ),
                                      marginSpaceMediumV,
                                      Text(
                                        ball['strikerName'],
                                        style: subtitleStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.sports_cricket_outlined,
                                      ),
                                      marginSpaceMediumV,
                                      Text(
                                        ball['nonStrikerName'],
                                        style: subtitleStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.sports_baseball,
                                      ),
                                      marginSpaceMediumV,
                                      Text(
                                        ball['bowlerName'],
                                        style: subtitleStyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    ball['timeStamp'].toString().split(".").first,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ballType,
                                    style: titleStyle,
                                  ),
                                  Text("${ball['runs']} runs"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  itemCount: matchDetailState.length,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(borderPadding),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      _shareJsonText();
                    },
                    style: primaryButtonStyle,
                    child: const Text("Share this Match")
                ),
              )
            ],
          ),
        
        ),
      )
    );
  }
}
