import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

import 'views/sign_up_email_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        authenticationService: getIt.get<AuthenticationService>(),
        userRepository: getIt.get<UserRepository>(),
        connectionChecker: getIt.get<ConnectionChecker>(),
      ),
      child: const SignUpEmailView(),
    );
  }
}
