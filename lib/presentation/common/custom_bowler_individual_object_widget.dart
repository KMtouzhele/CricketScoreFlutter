import 'package:crossplatform/presentation/common/constants.dart';
import 'package:flutter/material.dart';

class CustomBowlerIndividualObjectWidget extends StatelessWidget {
  final String name;
  final int runsLost;
  final int ballsDelivered;
  final int wickets;
  const CustomBowlerIndividualObjectWidget({
    super.key,
    required this.name,
    required this.runsLost,
    required this.ballsDelivered,
    required this.wickets,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent,
                ),
              ),
              marginSpaceSmall,
              Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        "RUNS LOST",
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                      Text(
                        runsLost.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        "BALLS DELIVERED",
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                      Text(
                        ballsDelivered.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        "WICKETS",
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                      Text(
                        wickets.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent,
                        ),
                      )
                    ],
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