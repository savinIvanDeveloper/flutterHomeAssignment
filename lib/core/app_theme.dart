import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    colorSchemeSeed: Color(0xfff9f5ea),
    brightness: Brightness.light,
  );

  static ThemeData get dark => ThemeData(
    colorSchemeSeed: Color(0xfff9f5ea),
    brightness: Brightness.dark,
  );
}
