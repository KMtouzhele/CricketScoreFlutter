import 'package:flutter/material.dart';

class BattingSetupPage extends StatelessWidget {
  const BattingSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Batting Setup"),
      ),
      body: const Center(
        child: Text(
          'This is the Create Match Page',
        ),
      ),
    );
  }
}