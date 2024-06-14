import 'package:crossplatform/data/datasource/fetch_ball_data.dart';
import 'package:crossplatform/domain/repositories/individual_repository.dart';
import 'package:crossplatform/domain/usecases/get_individual_results.dart';
import 'package:crossplatform/presentation/common/constants.dart';
import 'package:crossplatform/presentation/models/match_info_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_batter_individual_object_widget.dart';
import '../common/custom_bowler_individual_object_widget.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key});

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage>{
  List<Map<String, dynamic>> currentDisplay = [];
  final IndividualRepository individualRepository = FetchBallData();
  late final GetIndividualResults _getIndividualResults;
  List<Map<String, dynamic>> battersResult = [];
  List<Map<String, dynamic>> bowlersResult = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final matchInfoMap = Provider.of<MatchInfoModel>(context, listen: false).get();
    final matchId = matchInfoMap['MatchId'];
    _getIndividualResults = GetIndividualResults(individualRepository);
    _getIndividualResult(matchId!);
  }

  void _getIndividualResult(String matchId) async {
    battersResult = await _getIndividualResults.getBatterIndividual(matchId);
    bowlersResult = await _getIndividualResults.getBowlerIndividual(matchId);
    setState(() {
      currentDisplay = battersResult;
      isLoading = false;
    });
    print('CurrentDisplay: $currentDisplay');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Individual"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              if(isLoading)
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
              else if(battersResult.isEmpty || bowlersResult.isEmpty)
                  const Text(
                    "No players have played so far."
                )
              else Row(
                children: [
                  ChoiceChip(
                    label: const Text("Batters"),
                    selected: currentDisplay == battersResult,
                    onSelected: (bool selected) {
                      setState(() {
                        currentDisplay = battersResult;
                      });
                    },
                  ),
                  marginSpaceSmallV,
                  ChoiceChip(
                    label: const Text("Bowlers"),
                    selected: currentDisplay == bowlersResult,
                    onSelected: (bool selected) {
                      setState(() {
                        currentDisplay = bowlersResult;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (
                      BuildContext context,
                      int index
                      ) {
                    if (currentDisplay==battersResult){
                      var strikerResult = currentDisplay[index];
                      return CustomBatterIndividualObjectWidget(
                        name: strikerResult['name'] ?? 'Unknown',
                        runs: strikerResult['runs'] ?? 0,
                        ballsFaced: strikerResult['ballsFaced'] ?? 0,
                      );
                    } else {
                      var bowlerResult = currentDisplay[index];
                      return CustomBowlerIndividualObjectWidget(
                        name: bowlerResult['name'] ?? 'Unknown',
                        runsLost: bowlerResult['runsLost'] ?? 0,
                        ballsDelivered: bowlerResult['ballsDelivered'] ?? 0,
                        wickets: bowlerResult['wickets'] ?? 0
                      );
                    }
                  },
                  itemCount: currentDisplay.length,
                ),
              ),
            ],
          ),
        )
    );
  }
}
