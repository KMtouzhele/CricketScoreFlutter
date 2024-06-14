import 'package:flutter/material.dart';

import 'constants.dart';

class CustomBatterIndividualObjectWidget extends StatelessWidget {
  final String name;
  final int runs;
  final int ballsFaced;
  const CustomBatterIndividualObjectWidget({
    super.key,
    required this.name,
    required this.runs,
    required this.ballsFaced,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              marginSpaceSmall,
              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      const Text("RUNS"),
                      Text(
                        runs.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text("BALLS FACED"),
                      Text(
                        ballsFaced.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}