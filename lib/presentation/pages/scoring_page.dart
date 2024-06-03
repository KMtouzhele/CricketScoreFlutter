import 'package:crossplatform/data/datasource/fetch_team_info.dart';
import 'package:crossplatform/domain/repositories/scoring_repository.dart';
import 'package:crossplatform/domain/usecases/get_team_info.dart';
import 'package:crossplatform/presentation/common/constants.dart';
import 'package:crossplatform/presentation/common/custom_popup_menu_dark_widget.dart';
import 'package:crossplatform/presentation/common/custom_popup_menu_widget.dart';
import 'package:crossplatform/presentation/common/custom_toggle_text_button_widget.dart';
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

  Map<String, bool> buttonStates = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
    '5': false,
    '6': false,
    '7': false,
    '8': false,
    '4S': false,
    '6S': false,
    'NB': false,
    'WD': false,
    'B': false,
    'C': false,
    'LBW': false,
    'RO': false,
    'ST': false,
    'HW': false,
    'CB': false,
  };

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

  void toggleButtonState(String buttonKey) {
    setState(() {
      buttonStates.forEach((key, value) {
        if (key != buttonKey) {
          buttonStates[key] = false;
        }
      });
      buttonStates[buttonKey] = !buttonStates[buttonKey]!;
    });
  }

  void _emptyValidation(){
    if (!buttonStates.containsValue(true)) {
      _showSnackBar("Please select a ball result!");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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


    if (batters.isEmpty || bowlers.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Column(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreenAccent),
              ),
              Text("Loading..."),
            ],
          ),
        ),
      );
    }


    final matchProgress = Provider.of<MatchProgressModel>(context).get();
    final currentStrikerId = matchProgress['currentStrikerId'];
    final currentNonStrikerId = matchProgress['currentNonStrikerId'];
    final currentBowlerId = matchProgress['currentBowlerId'];

    final currentStriker = batters.firstWhere((element) => element['id'] == currentStrikerId, orElse: () => {'name': 'Select'});
    final currentNonStriker = batters.firstWhere((element) => element['id'] == currentNonStrikerId, orElse: () => {'name': 'Select'});
    final currentBowler = bowlers.firstWhere((element) => element['id'] == currentBowlerId, orElse: () => {'name': 'Select'});

    return Scaffold(
    appBar: AppBar(
      title: const Text("Scoring"),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16,),
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
                          Icon(Icons.person),
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
                          Icon(Icons.sports_cricket_rounded, color: Colors.purpleAccent,),
                          CustomPopupMenuButton(
                              initialPlayer: currentStriker,
                              items: batters,
                              onSelected: (Map<String, dynamic> selectedPlayer) {
                                context.read<MatchProgressModel>().changeStriker(selectedPlayer['id']);
                                print('Current StrikerId: ${matchProgress['currentStrikerId']}');
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
                          Icon(Icons.sports_cricket_outlined),
                          CustomPopupMenuButton(
                            initialPlayer: currentNonStriker,
                            items: batters,
                            onSelected: (Map<String, dynamic> selectedPlayer) {
                              context.read<MatchProgressModel>().changeNonStriker(selectedPlayer['id']);
                              print('Current nonStrikerId: ${matchProgress['currentNonStrikerId']}');
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
            marginSpaceMedium,
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
                          Icon(Icons.person, color: Colors.lightGreenAccent,),
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
                          Icon(Icons.sports_baseball, color: Colors.lightGreenAccent,),
                          CustomPopupMenuButtonDark(
                              initialPlayer: currentBowler,
                              items: bowlers,
                              onSelected: (Map<String, dynamic> selectedPlayer) {
                                context.read<MatchProgressModel>().changeBowler(selectedPlayer['id']);
                                print('Current bowlerId: ${matchProgress['currentBowlerId']}');
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
            marginSpaceMedium,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomToggleTextButtonWidget(
                        onPressed:() => toggleButtonState('1'),
                        isSelected: buttonStates['1'] ?? false,
                        text: "1",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('2'),
                        isSelected: buttonStates['2'] ?? false,
                        text: "2",),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('3'),
                        isSelected: buttonStates['3'] ?? false,
                        text: "3",),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('4'),
                        isSelected: buttonStates['4'] ?? false,
                        text: "4",),
                    ],
                  ),
                  Row(
                    children: [
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('5'),
                        isSelected: buttonStates['5'] ?? false,
                        text: "5",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('6'),
                        isSelected: buttonStates['6'] ?? false,
                        text: "6",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('7'),
                        isSelected: buttonStates['7'] ?? false,
                        text: "7",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('8'),
                        isSelected: buttonStates['8'] ?? false,
                        text: "8",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('4S'),
                        isSelected: buttonStates['4S'] ?? false,
                        text: "4S",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('6S'),
                        isSelected: buttonStates['6S'] ?? false,
                        text: "6S",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('NB'),
                        isSelected: buttonStates['NB'] ?? false,
                        text: "NB",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('WD'),
                        isSelected: buttonStates['WD'] ?? false,
                        text: "WD",
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                  Row(
                    children: [
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('B'),
                        isSelected: buttonStates['B'] ?? false,
                        text: "B",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('C'),
                        isSelected: buttonStates['C'] ?? false,
                        text: "C",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('LBW'),
                        isSelected: buttonStates['LBW'] ?? false,
                        text: "LBW",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('RO'),
                        isSelected: buttonStates['RO'] ?? false,
                        text: "RO",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('ST'),
                        isSelected: buttonStates['ST'] ?? false,
                        text: "ST",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('HW'),
                        isSelected: buttonStates['HW'] ?? false,
                        text: "HW",
                      ),
                      marginSpaceSmallV,
                      CustomToggleTextButtonWidget(
                        onPressed: () => toggleButtonState('CB'),
                        isSelected: buttonStates['CB'] ?? false,
                        text: "C&B",
                      ),
                      marginSpaceSmallV,
                      Expanded(
                        child: IconButton(
                          onPressed: (){
                            _emptyValidation();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.purpleAccent),
                            foregroundColor: WidgetStateProperty.all(Colors.lightGreenAccent),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            )),
                          ),
                          icon: const Icon(
                            Icons.check_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}