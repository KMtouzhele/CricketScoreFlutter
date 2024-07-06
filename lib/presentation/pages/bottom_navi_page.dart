import 'individual_page.dart';
import 'scoring_page.dart';
import 'settings_page.dart';
import 'summary_page.dart';
import 'package:flutter/material.dart';

import '../common/bottom_navigation.dart';

class BottomNaviPage extends StatefulWidget {
  const BottomNaviPage({super.key});


  @override
  State<BottomNaviPage> createState() => _BottomNaviPageState();
}

class _BottomNaviPageState extends State<BottomNaviPage> {


  int _currentTab = 0;

  final List<Widget> _subPages = [
    const ScoringPage(),
    const SummaryPage(),
    const IndividualPage(),
    const SettingsPage()
  ];


  void onTabTapped(int tabIndex) {
    setState(() {
      _currentTab = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _subPages[_currentTab],
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentTab,
        onTabTapped: onTabTapped,
      ),
    );
  }
}