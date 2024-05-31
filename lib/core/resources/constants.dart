import 'package:flutter/material.dart';

const double borderPadding = 16.0;

const TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

const TextStyle subtitleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

const TextStyle subtitleStyleDark = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

const SizedBox marginSpaceSmall = SizedBox(height: 8.0);

const SizedBox marginSpaceMedium = SizedBox(height: 16.0);

const SizedBox marginSpaceLarge = SizedBox(height: 32.0);

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