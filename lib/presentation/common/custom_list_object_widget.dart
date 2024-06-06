import 'package:flutter/material.dart';

class CustomListObjectWidget extends StatelessWidget {
  final String name;
  final String status;
  final String id;
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  const CustomListObjectWidget({
    super.key,
    required this.name,
    required this.status,
    required this.id,
    required this.onPressed,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(status),
                  Text(
                    id,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete)
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.edit),
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