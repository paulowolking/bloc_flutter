import 'package:flutter/material.dart';

final byteBankTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.green,
    accentColor: Colors.blueAccent[700],
  ).copyWith(
    secondary: Colors.blueAccent[700],
  ),
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent[700], textTheme: ButtonTextTheme.primary),
);
