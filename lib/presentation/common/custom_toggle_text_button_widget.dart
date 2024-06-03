import 'package:flutter/material.dart';

class CustomToggleTextButtonWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onPressed;

  const CustomToggleTextButtonWidget({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.lightGreenAccent : Colors.black,
          backgroundColor: isSelected ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

