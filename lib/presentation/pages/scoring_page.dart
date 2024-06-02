import 'package:crossplatform/data/datasource/fetch_team_info.dart';
import 'package:crossplatform/domain/repositories/scoring_repository.dart';
import 'package:crossplatform/domain/usecases/get_team_info.dart';
import 'package:crossplatform/presentation/common/custom_popup_menu_dark_widget.dart';
import 'package:crossplatform/presentation/common/custom_popup_menu_widget.dart';
import 'package:crossplatform/presentation/models/match_info_model.dart';
import 'package:crossplatform/presentation/models/players_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/match_progress_model.dart';

class ScoringPage extends StatefulWidget {
  const ScoringPage({super.key});

  @override
  State<ScoringPage> createState() => _ScoringPageState();
}

class _ScoringPageState extends State<ScoringPage>{
  final ScoringRepository _scoringRepository = FetchTeamInfo();
  late final GetTeamInfo _getTeamInfo;
  String selectedBatterName = 'Select';
  String selectedNonStrikerName = 'Select';
  String selectedBowlerName = 'Select';


  @override
  void initState() {
    super.initState();
    _getTeamInfo = GetTeamInfo(_scoringRepository);
  }

  void _fetchTeamInfo(String battingTeamId, String bowlingTeamId) async {
      final batters = await _getTeamInfo.getTeamInfo(battingTeamId);
      final bowlers = await _getTeamInfo.getTeamInfo(bowlingTeamId);
      context.read<PlayersModel>().addBatters(batters);
      context.read<PlayersModel>().addBowlers(bowlers);
  }

  @override
  Widget build(BuildContext context) {

    final matchInfo = Provider.of<MatchInfoModel>(context).get();
    final battingTeamId = matchInfo['BattingTeamId'];
    final bowlingTeamId = matchInfo['BowlingTeamId'];
    if (battingTeamId == null || bowlingTeamId == null) {
      print('Team Ids are null');
    } else {
      _fetchTeamInfo(battingTeamId, bowlingTeamId);
    }
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    final batters = context.watch<PlayersModel>().getBatters();
    final bowlers = context.watch<PlayersModel>().getBowlers();

    final matchProgress = Provider.of<MatchProgressModel>(context).get();
    return Scaffold(
    appBar: AppBar(
      title: const Text("Scoring"),
    ),
    body: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Batters",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Runs"),
                        Text("Balls Faced"),
                        Text("Fours"),
                        Text("Sixes"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        CustomPopupMenuButton(
                            initialValue: selectedBatterName,
                            items: batters,
                            onSelected: (String name) {
                              setState(() {
                                selectedBatterName = name;
                              });
                            },
                        ),
                        Text(matchProgress['strikerRuns'].toString()),
                        Text(matchProgress['strikerBalls'].toString()),
                        Text(matchProgress['strikerFours'].toString()),
                        Text(matchProgress['strikerSixes'].toString()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        CustomPopupMenuButton(
                          initialValue: selectedNonStrikerName,
                          items: batters,
                          onSelected: (String name) {
                            setState(() {
                              selectedNonStrikerName = name;
                            });
                          },
                        ),
                        Text(matchProgress['nonStrikerRuns'].toString()),
                        Text(matchProgress['nonStrikerBalls'].toString()),
                        Text(matchProgress['nonStrikerFours'].toString()),
                        Text(matchProgress['nonStrikerSixes'].toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bowler",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                        Text(
                            "Wickets",
                            style: TextStyle(color: Colors.lightGreenAccent)
                        ),
                        Text(
                            "Runs Lost",
                            style: TextStyle(color: Colors.lightGreenAccent)
                        ),
                        Text(
                            "Balls Bowled",
                            style: TextStyle(color: Colors.lightGreenAccent)
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        CustomPopupMenuButtonDark(
                            initialValue: selectedBowlerName,
                            items: bowlers,
                            onSelected: (String name) {
                              setState(() {
                                selectedBowlerName = name;
                              });
                            },
                        ),
                        Text(
                            matchProgress['bowlerWickets'].toString(),
                            style: const TextStyle(color: Colors.lightGreenAccent)
                        ),
                        Text(
                            matchProgress['bowlerRunsLost'].toString(),
                            style: const TextStyle(color: Colors.lightGreenAccent)
                        ),
                        Text(
                            matchProgress['bowlerBalls'].toString(),
                            style: const TextStyle(color: Colors.lightGreenAccent)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}