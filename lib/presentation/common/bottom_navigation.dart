import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavigationBarWidget({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  //TODO: https://stackoverflow.com/questions/49307858/style-bottomnavigationbar-in-flutter
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.lightGreenAccent,
      unselectedItemColor: Colors.white,
      onTap: onTabTapped,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_cricket),
          label: 'Score',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.summarize_outlined),
          label: 'Summary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Individual',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}