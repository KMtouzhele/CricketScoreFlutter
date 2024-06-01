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