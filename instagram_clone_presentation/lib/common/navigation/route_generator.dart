import 'package:flutter/material.dart';

import '../../authentication/sign_up/sign_up_page.dart';
import '../../authentication/sign_up/views/sign_up_email_verification_view.dart';
import '../../authentication/sign_up/views/sign_up_email_view.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Home")),
          ),
        );
      case RouteNames.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case RouteNames.signUpEmail:
        return MaterialPageRoute(builder: (context) => const SignUpEmailView());
      case RouteNames.signUpEmailVerification:
        return MaterialPageRoute(
            builder: (context) => const SignUpEmailVerificationView());
      default:
        return _errorRoute(settings);
    }
  }
}

Route<dynamic> _errorRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      body: Center(
        child: Text('Error occurred navigating to ${settings.name}'),
      ),
    ),
  );
}
