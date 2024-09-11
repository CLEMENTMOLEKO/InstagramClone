import 'package:flutter/material.dart';

enum AppThemes { dark, light }

final appTheme = {
  AppThemes.dark: ThemeData(brightness: Brightness.dark),
  AppThemes.light: ThemeData(brightness: Brightness.light)
};
