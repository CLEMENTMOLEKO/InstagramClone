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
            colors: [Theme.of(context).colorScheme.onPrimary, Colors.blue],
            stops: const [.05, .95],
            transform: const GradientRotation(-.5)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(.7),
          child: child,
        ),
      ),
    );
  }
}
