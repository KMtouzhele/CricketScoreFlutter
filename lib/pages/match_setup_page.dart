import 'package:flutter/material.dart';
import '../data/datasource/match_setup_data.dart';
import '../domain/entities/player.dart';
import '../domain/repositories/match_repository.dart';
import '../domain/usecases/user_create_match.dart';
import 'common/constants.dart';
import 'common/widgets.dart';

class MatchSetupPage extends StatefulWidget {
  const MatchSetupPage({super.key});

  @override
  State<MatchSetupPage> createState() => _MatchSetupPageState();
}

class _MatchSetupPageState extends State<MatchSetupPage> {
  final TextEditingController _battingTeamController = TextEditingController();
  final TextEditingController _bowlingTeamController = TextEditingController();
  final List<TextEditingController> _batterControllers = List.generate(5, (index) => TextEditingController());
  final List<TextEditingController> _bowlerControllers = List.generate(5, (index) => TextEditingController());

  final MatchRepository _matchRepository = MatchSetupData();
  late final UserCreateMatch _userCreateMatch;

  @override
  void initState(){
    super.initState();
    _userCreateMatch = UserCreateMatch(_matchRepository);
  }

  Future<void> _startMatch() async {
    if (!isInputEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields"),
        ),
      );
      return;
    }

    if (isInputRepeated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter unique names"),
        ),
      );
      return;
    }
    String battingTeamName = _battingTeamController.text;
    String bowlingTeamName = _bowlingTeamController.text;
    Map<String, int> battersMap = {};
    Map<String, int> bowlersMap = {};
    for (var i = 0; i < 5; i++) {
      if (_batterControllers[i].text.isNotEmpty) {
        battersMap[_batterControllers[i].text] = i + 1;
      }
      if (_bowlerControllers[i].text.isNotEmpty) {
        bowlersMap[_bowlerControllers[i].text] = i + 1;
      }
    }
     Map<String, String> matchInfo = await _userCreateMatch.createMatch(
         battingTeamName, bowlingTeamName, battersMap, bowlersMap
     );
    print(matchInfo);
  }

  bool isInputEmpty() {
    if (_battingTeamController.text.isEmpty) {
      return false;
    }
    if (_bowlingTeamController.text.isEmpty) {
      return false;
    }
    for (var i = 0; i < 5; i++) {
      if (_batterControllers[i].text.isEmpty) {
        return false;
      }
      if (_bowlerControllers[i].text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool isInputRepeated() {
    List<String> allNames = [];
    allNames.add(_battingTeamController.text);
    allNames.add(_bowlingTeamController.text);
    for (var i = 0; i < 5; i++) {
      allNames.add(_batterControllers[i].text);
      allNames.add(_bowlerControllers[i].text);
    }
    for (var i = 0; i < allNames.length; i++) {
      for (var j = i + 1; j < allNames.length; j++) {
        if (allNames[i] == allNames[j]) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    return Scaffold(
    appBar: AppBar(
      title: const Text(
        "Match Setup",
        style: titleStyle,
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 4.0, top: 32.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Batting Team",
                        style: subtitleStyle,
                      ),
                      marginSpaceSmall,
                      commonTextField("Team Name", _battingTeamController),
                      marginSpaceLarge,
                      const Text(
                        "Batters",
                        style: subtitleStyle,
                      ),
                      marginSpaceSmall,
                      ...List.generate(5, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: commonTextField(
                                  "Batter${index + 1}",
                                  _batterControllers[index]
                              ),
                            ),
                          ],
                        ),
                      )),
                      marginSpaceMedium,
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 16.0, top: 32.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Bowling Team",
                        style: subtitleStyleDark,

                      ),
                      marginSpaceSmall,
                      commonTextFieldDark("Team Name", _bowlingTeamController),
                      marginSpaceLarge,
                      const Text(
                        "Bowlers",
                        style: subtitleStyleDark,
                      ),
                      marginSpaceSmall,
                      ...List.generate(5, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.lightGreenAccent,
                              ),
                            ),
                            Expanded(
                              child: commonTextFieldDark(
                                  "Bowler${index + 1}",
                                  _bowlerControllers[index]
                              ),
                            ),
                          ],
                        ),
                      )),
                      marginSpaceMedium,
                    ],
                  ),
                ),
              ),
            ),
          ],
          ),
          Container(
            padding: const EdgeInsets.all(borderPadding),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: _startMatch,
                style: primaryButtonStyle,
                child:
                const Text("Start Match"),
            ),
          ),
        ],
      ),
    ),
  );
  }
}