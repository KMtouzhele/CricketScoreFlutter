import 'package:crossplatform/presentation/common/constants.dart';
import 'package:crossplatform/presentation/models/match_progress_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_summary_container_widget.dart';
import '../common/custom_summary_team_container_widget.dart';
import '../models/players_model.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>{
  String battingScore = "0 / 0";
  String extras = "0";
  String runRate = "0.00";
  String overs = "0.0";
  String strikerName = "To be selected";
  String nonStrikerName = "To be selected";
  String bowlerName = "To be selected";

  @override
  Widget build(BuildContext context) {
    final matchProgressMap = Provider.of<MatchProgressModel>(context).get();
    final batters = Provider.of<PlayersModel>(context).getBatters();
    final bowlers = Provider.of<PlayersModel>(context).getBowlers();
    String currentStrikerId = matchProgressMap['currentStrikerId'];
    String currentNonStrikerId = matchProgressMap['currentNonStrikerId'];
    String currentBowlerId = matchProgressMap['currentBowlerId'];
    print("currentStrikerId: $currentStrikerId");
    print("currentNonStrikerId: $currentNonStrikerId");
    print("currentBowlerId: $currentBowlerId");
    if (currentStrikerId.isNotEmpty) {
      var striker = batters.where((element) => element['id'] == currentStrikerId).firstOrNull;
      if (striker != null) {
        strikerName = striker['name'] ?? "To be selected";
      }
    }
    if (currentNonStrikerId.isNotEmpty) {
      var nonStriker = batters.where((element) => element['id'] == currentNonStrikerId).firstOrNull;
      if (nonStriker != null) {
        nonStrikerName = nonStriker['name'] ?? "To be selected";
      }
    }
    if (currentBowlerId.isNotEmpty) {
      var bowler = bowlers.where((element) => element['id'] == currentBowlerId).firstOrNull;
      if (bowler != null) {
        bowlerName = bowler['name'] ?? "To be selected";
      }
    }
    double newRunRate = matchProgressMap['totalRuns'] / (matchProgressMap['totalBallDelivered'] / 6);
    runRate = newRunRate.toStringAsFixed(3);
    return buildScaffold(matchProgressMap);
  }


  Scaffold buildScaffold(Map<String, dynamic> matchProgressMap) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Summary"),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomSummaryContainerWidget(
                    title:"OVERS",
                    value: "${matchProgressMap['currentOver']}.${matchProgressMap['currentBall']}",
                  ),
                  marginSpaceMediumV,
                  Expanded(
                    child: CustomSummaryTeamContainerWidget(
                      battingTeamName: "Team A",
                      bowlingTeamName: "Team B",
                      strikerName: strikerName,
                      nonStrikerName: nonStrikerName,
                      bowlerName: bowlerName,
                    ),
                  ),
                ],
              ),
            ),
            marginSpaceMedium,
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: CustomSummaryContainerWidget(
                      title:"BATTING SCORE",
                      value: "${matchProgressMap['totalWickets']} / ${matchProgressMap['totalRuns']}",
                    ),
                  ),
                  marginSpaceMediumV,
                  Expanded(
                    child: CustomSummaryContainerWidget(
                      title:"EXTRAS",
                      value: matchProgressMap['totalExtras'].toString(),
                    ),
                  ),
                ],
              ),
            ),
            marginSpaceMedium,
            Row(
              children: [
                Expanded(
                  child: CustomSummaryContainerWidget(
                    title:"RUN RATE",
                    value: runRate,
                  ),
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

