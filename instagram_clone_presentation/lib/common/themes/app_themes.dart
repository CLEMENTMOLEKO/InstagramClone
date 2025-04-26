import 'package:flutter/material.dart';

import 'theme_extensions.dart';

class InstagramCloneThemes {
  static const _lightScaffoldBackgroundColor = Colors.white;
  static const _darkScaffoldBackgroundColor = Colors.black87;
  static final _darkSecondaryScaffoldBackgroundColor = Colors.grey[900]!;

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      scaffoldBackgroundColor: _lightScaffoldBackgroundColor,
      extensions: [
        InstagramCloneThemeExtension(
          secondaryScaffoldBackgroundColor: _lightScaffoldBackgroundColor,
        ),
      ],
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: _lightScaffoldBackgroundColor,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: _lightScaffoldBackgroundColor,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      scaffoldBackgroundColor: _darkScaffoldBackgroundColor,
      extensions: [
        InstagramCloneThemeExtension(
          secondaryScaffoldBackgroundColor:
              _darkSecondaryScaffoldBackgroundColor,
        ),
      ],
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: _darkScaffoldBackgroundColor,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: _darkScaffoldBackgroundColor,
      ),
    );
  }
}
