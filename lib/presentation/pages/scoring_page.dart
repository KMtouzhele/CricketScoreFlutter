import 'package:crossplatform/presentation/models/match_info_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoringPage extends StatefulWidget {
  const ScoringPage({super.key});

  @override
  State<ScoringPage> createState() => _ScoringPageState();
}

class _ScoringPageState extends State<ScoringPage>{
  @override
  Widget build(BuildContext context) {
    final matchInfo = Provider.of<MatchInfoModel>(context).get();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scoring"),
      ),
      body: Center(
        child: Text('Match ID: ${matchInfo['MatchId']}'),
      ),
    );
  }
}