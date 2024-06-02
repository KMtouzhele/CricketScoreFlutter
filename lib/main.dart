import 'package:crossplatform/presentation/models/match_info_model.dart';
import 'package:crossplatform/presentation/models/match_progress_model.dart';
import 'package:crossplatform/presentation/models/players_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/pages/match_history_page.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MatchInfoModel()),
        ChangeNotifierProvider(create: (context) => PlayersModel()),
        ChangeNotifierProvider(create: (context) => MatchProgressModel()),
      ],
      child: MaterialApp(
        title: 'CricketScore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          useMaterial3: true,
        ),
        home: const MatchHistoryPage(),
      ),
    );
  }
}
