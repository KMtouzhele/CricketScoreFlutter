import 'package:flutter/material.dart';
import '../../../core/resources/constants.dart';
import '../../match_setup/presentation/match_setup_page.dart';

class MatchHistoryPage extends StatefulWidget {
  const MatchHistoryPage({super.key});

  @override
  State<MatchHistoryPage> createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.all(borderPadding),
                    child: const Text(
                      "Match History",
                      style: titleStyle,
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