import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const seed = Color(0xFF1B5E20);

  static final light = ThemeData(colorSchemeSeed: seed, useMaterial3: true);
}
