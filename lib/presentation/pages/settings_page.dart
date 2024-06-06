import 'package:crossplatform/data/datasource/update_player_data.dart';
import 'package:crossplatform/domain/repositories/update_player_repository.dart';
import 'package:crossplatform/domain/usecases/user_settings.dart';
import 'package:crossplatform/presentation/common/constants.dart';
import 'package:crossplatform/presentation/common/widgets.dart';
import 'package:crossplatform/presentation/models/players_model.dart';
import 'package:crossplatform/presentation/pages/match_history_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_list_object_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  List<Map<String, dynamic>> currentDisplay = [];
  final UpdatePlayerRepository _updatePlayerRepository = UpdatePlayerData();
  late final UserSettings _userSettings;

  @override
  void initState() {
    super.initState();
    final playersModel = Provider.of<PlayersModel>(context, listen: false);
    final battersList = playersModel.getBatters();
    currentDisplay = battersList;
    _userSettings = UserSettings(_updatePlayerRepository, playersModel);
  }

  void _showEditingDialog(String name, String status, String id){
    final nameController = TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Edit Player"),
          content: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: $id",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                marginSpaceMedium,
                Text("This player is $status."),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                _userSettings.updatePlayerName(id, nameController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

  }

  void _showDeleteDialog(String name, String status, String id){
    showDialog(
      context: context,
      builder: (BuildContext context){
        if (status != 'available') {
          return AlertDialog(
            title: const Text("Delete Player"),
            content: Text("You cannot delete player $name because they are currently $status."),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        }
        return AlertDialog(
          title: const Text("Delete Player"),
          content: Text("Are you sure you want to delete player $name?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                _userSettings.deletePlayer(id);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNewMatchDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Start A New Match"),
            content: const IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("This will end this match and start a new match."),
                  marginSpaceMedium,
                  Text("Are you sure you want to start a new match?"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MatchHistoryPage(),
                    ),
                  );
                },
                child: const Text(
                  "Start New Match",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    final battersList = Provider.of<PlayersModel>(context).getBatters();
    final bowlersList = Provider.of<PlayersModel>(context).getBowlers();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ChoiceChip(
                  label: const Text("Batters"),
                  selected: currentDisplay == battersList,
                  onSelected: (bool selected) {
                    setState(() {
                      currentDisplay = selected ? battersList : bowlersList;
                    });
                  },
                ),
                marginSpaceSmallV,
                ChoiceChip(
                  label: const Text("Bowlers"),
                  selected: currentDisplay == bowlersList,
                  onSelected: (bool selected) {
                    setState(() {
                      currentDisplay = selected ? bowlersList : battersList;
                    });
                    print('Bowlers selected');
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (
                    BuildContext context,
                    int index
                    ) {
                  var batter = currentDisplay[index];
                  return CustomListObjectWidget(
                    name: "${batter['name']}",
                    status: batter['status'],
                    id: batter['id'],
                    onPressed: (){
                      _showEditingDialog(
                        batter['name'],
                        batter['status'],
                        batter['id'],
                      );
                      print('Tapped');
                    },
                    onDelete: (){
                      _showDeleteDialog(
                        batter['name'],
                        batter['status'],
                        batter['id'],
                      );
                      print('Try to delete');
                    },
                  );
                },
                itemCount: currentDisplay.length,
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Start a New Match'),
                style: primaryButtonStyle,
                onPressed: (){
                  _showNewMatchDialog();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

