import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  final AuthenticationService? authenticationService;
  final UserRepository? userRepository;
  final ConnectionChecker? connectionChecker;
  final EmailService? emailService;

  const SignUpPage({
    super.key,
    this.authenticationService,
    this.userRepository,
    this.connectionChecker,
    this.emailService,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        emailService: emailService ?? getIt.get<EmailService>(),
        authenticationService:
            authenticationService ?? getIt.get<AuthenticationService>(),
        userRepository: userRepository ?? getIt.get<UserRepository>(),
        connectionChecker: connectionChecker ?? getIt.get<ConnectionChecker>(),
      ),
      child: const AutoRouter(),
    );
  }
}
