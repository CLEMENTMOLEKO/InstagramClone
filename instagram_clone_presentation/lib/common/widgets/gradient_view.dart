import 'dart:ui';

import 'package:flutter/material.dart';

class GradientView extends StatelessWidget {
  final Widget child;
  const GradientView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.blue],
            stops: [.05, .95],
            transform: GradientRotation(-.5)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(.7),
          child: child,
        ),
      ),
    );
  }
}
