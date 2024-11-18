import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  final Widget child;
  const AuthenticationPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
