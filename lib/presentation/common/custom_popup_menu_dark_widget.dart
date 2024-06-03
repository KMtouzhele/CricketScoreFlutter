import 'package:flutter/material.dart';

class CustomPopupMenuButtonDark extends StatelessWidget {
  final Map<String, dynamic> initialPlayer;
  final List<Map<String, dynamic>> items;
  final void Function(Map<String, dynamic>) onSelected;

  const CustomPopupMenuButtonDark({
    super.key,
    required this.initialPlayer,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Map<String, dynamic>>(
      initialValue: initialPlayer,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((item) {
          return PopupMenuItem<Map<String, dynamic>>(
            value: item,
            child: Text(item['name']),
          );
        }).toList();
      },
      child: Text(
        initialPlayer['name'],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent,
        ),
      ),
    );
  }
}
