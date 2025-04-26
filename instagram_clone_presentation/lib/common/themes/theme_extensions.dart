import 'package:flutter/material.dart';

@immutable
class InstagramCloneThemeExtension
    extends ThemeExtension<InstagramCloneThemeExtension> {
  const InstagramCloneThemeExtension(
      {required this.secondaryScaffoldBackgroundColor});

  final Color? secondaryScaffoldBackgroundColor;

  @override
  InstagramCloneThemeExtension copyWith(
      {Color? secondaryScaffoldBackgroundColor}) {
    return InstagramCloneThemeExtension(
        secondaryScaffoldBackgroundColor: secondaryScaffoldBackgroundColor ??
            this.secondaryScaffoldBackgroundColor);
  }

  @override
  InstagramCloneThemeExtension lerp(
      InstagramCloneThemeExtension? other, double t) {
    if (other is! InstagramCloneThemeExtension) {
      return this;
    }
    return InstagramCloneThemeExtension(
      secondaryScaffoldBackgroundColor: Color.lerp(
          secondaryScaffoldBackgroundColor,
          other.secondaryScaffoldBackgroundColor,
          t),
    );
  }

  // Optional
  @override
  String toString() =>
      'InstagramCloneThemeExtension(secondaryScaffoldBackgroundColor: $secondaryScaffoldBackgroundColor)';
}
