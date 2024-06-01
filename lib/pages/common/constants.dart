import 'package:flutter/material.dart';

const double borderPadding = 16.0;

const TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

const TextStyle subtitleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

const TextStyle subtitleStyleDark = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent);

const SizedBox marginSpaceSmall = SizedBox(height: 8.0);

const SizedBox marginSpaceMedium = SizedBox(height: 16.0);

const SizedBox marginSpaceLarge = SizedBox(height: 32.0);

ButtonStyle primaryButtonStyle = const ButtonStyle(
 backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
 foregroundColor: WidgetStatePropertyAll<Color>(Colors.lightGreenAccent),
 shadowColor: WidgetStatePropertyAll<Color>(Colors.lightGreenAccent),
 textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
 )),
);

