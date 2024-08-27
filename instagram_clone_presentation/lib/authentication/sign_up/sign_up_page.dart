import 'package:flutter/material.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import 'views/sign_up_email_view.dart';

class SignUpPage extends StatelessWidget {
  final AuthenticationService? authenticationService;
  final UserRepository? userRepository;
  final ConnectionChecker? connectionChecker;

  const SignUpPage({
    super.key,
    this.authenticationService,
    this.userRepository,
    this.connectionChecker,
  });

  @override
  Widget build(BuildContext context) {
    return const SignUpEmailView();
  }
}
