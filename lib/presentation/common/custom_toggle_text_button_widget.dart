import 'package:flutter/material.dart';

class CustomToggleTextButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomToggleTextButtonWidget({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  CustomToggleTextButtonWidgetState createState() => CustomToggleTextButtonWidgetState();
}

class CustomToggleTextButtonWidgetState extends State<CustomToggleTextButtonWidget> {
  bool isSelected = false;

  void _toggleButton() {
    setState(() {
      isSelected = !isSelected;
    });
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: _toggleButton,
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.lightGreenAccent : Colors.black,
          backgroundColor: isSelected ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
    );
  }
}