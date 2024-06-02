import 'package:flutter/material.dart';

TextField commonTextField(String hint, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      labelText: hint,
    ),
  );
}

TextField commonTextFieldDark(String hint, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.white)
      ),
      labelText: hint,
      labelStyle: const TextStyle(color: Colors.white70),
    ),
    style: const TextStyle(
      color: Colors.lightGreenAccent,
    ),
  );
}

ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey; // Disabled color
      }
      return Colors.black; // Regular color
    },
  ),
  foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.black; // Disabled color
      }
      return Colors.lightGreenAccent; // Regular color
    },
  ),
  overlayColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.grey; // Overlay color when button is pressed
      }
      return Colors.transparent;
    },
  ),
  shadowColor: WidgetStateProperty.all<Color>(Colors.lightGreenAccent),
  textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  )),
);