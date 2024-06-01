import 'package:flutter/material.dart';
import 'pages/match_history_page.dart';
import 'package:crossplatform/firestore/firestore_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirestoreService.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CricketScore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        useMaterial3: true,
      ),
      home: const MatchHistoryPage(),
    );
  }
}
