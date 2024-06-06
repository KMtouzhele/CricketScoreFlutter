import 'package:flutter/material.dart';

import 'constants.dart';

class CustomSummaryTeamContainerWidget extends StatelessWidget {
  final String battingTeamName;
  final String bowlingTeamName;
  final String strikerName;
  final String nonStrikerName;
  final String bowlerName;
  const CustomSummaryTeamContainerWidget({
    super.key,
    required this.battingTeamName,
    required this.bowlingTeamName,
    required this.strikerName,
    required this.nonStrikerName,
    required this.bowlerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            "$battingTeamName vs $bowlingTeamName",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.lightGreenAccent,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.sports_cricket,
                color: Colors.purpleAccent,
              ),
              marginSpaceSmallV,
              Text(
                strikerName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent,
                ),
              ),
            ],
          ),
          marginSpaceSmall,
          Row(
            children: [
              const Icon(
                Icons.sports_cricket_outlined,
                color: Colors.lightGreenAccent,
              ),
              marginSpaceSmallV,
              Text(
                nonStrikerName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent,
                ),
              ),
            ],
          ),
          marginSpaceSmall,
          Row(
            children: [
              const Icon(
                Icons.sports_baseball,
                color: Colors.lightGreenAccent,
              ),
              marginSpaceSmallV,
              Text(
                bowlerName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}