import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Map<String, dynamic> initialPlayer;
  final List<Map<String, dynamic>> items;
  final void Function(Map<String, dynamic>) onSelected;

  const CustomPopupMenuButton({
    super.key,
    required this.initialPlayer,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item)=> item['status'] != 'dismissed').toList();

    return PopupMenuButton<Map<String, dynamic>>(
      initialValue: initialPlayer,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return filteredItems.map((item) {
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
        ),
      ),
    );
  }
}
