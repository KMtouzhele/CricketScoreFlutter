import 'package:flutter/material.dart';

TextField playerTextField(String hint) {
  return TextField(
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      labelText: hint,
    ),
  );
}

TextField playerTextFieldDark(String hint) {
  return TextField(
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.white)
      ),
      labelText: hint,
      labelStyle: const TextStyle(color: Colors.white70),
    ),
  );
}