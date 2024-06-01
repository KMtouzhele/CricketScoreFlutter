import 'package:flutter/material.dart';
import '../../../core/resources/constants.dart';
import '../../../core/resources/widgets.dart';

class MatchSetupPage extends StatelessWidget {
  const MatchSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Team Name",
                          ),
                        ),
                        marginSpaceLarge,
                        const Text(
                          "Batters",
                          style: subtitleStyle,
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: playerTextField("Batter1")
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: playerTextField("Batter2")
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: playerTextField("Batter3")
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: playerTextField("Batter4")
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                                child: playerTextField("Batter5")
                            ),
                          ],
                        ),
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
                        const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Team Name",
                          ),
                        ),
                        marginSpaceLarge,
                        const Text(
                          "Bowlers",
                          style: subtitleStyleDark,
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.lightGreenAccent,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child:
                              playerTextFieldDark("Bowler1"),
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.lightGreenAccent,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child:
                              playerTextFieldDark("Bowler2"),
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.lightGreenAccent,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child:
                              playerTextFieldDark("Bowler3"),
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.lightGreenAccent,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child:
                              playerTextFieldDark("Bowler4"),
                            ),
                          ],
                        ),
                        marginSpaceSmall,
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.lightGreenAccent,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child:
                              playerTextFieldDark("Bowler5"),
                            ),
                          ],
                        ),
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
                  onPressed: (){},
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