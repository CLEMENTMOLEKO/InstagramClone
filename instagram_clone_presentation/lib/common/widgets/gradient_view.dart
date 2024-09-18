import 'dart:ui';

import 'package:flutter/material.dart';

class GradientView extends StatelessWidget {
  final Widget child;
  const GradientView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              // Theme.of(context).colorScheme.primary,
              Colors.blue,
            ],
            tileMode: TileMode.decal,
            transform: const GradientRotation(-.5)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.7),
          child: child,
        ),
      ),
    );
  }
}
