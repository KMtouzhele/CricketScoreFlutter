import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final String initialValue;
  final List<Map<String, dynamic>> items;
  final void Function(String) onSelected;

  const CustomPopupMenuButton({
    super.key,
    required this.initialValue,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: initialValue,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item['name'],
            child: Text(item['name']),
          );
        }).toList();
      },
      child: Text(
        initialValue,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
