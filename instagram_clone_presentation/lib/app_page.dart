import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

import 'common/navigation/router.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationService: getIt<AuthenticationService>(),
        userRepository: getIt<UserRepository>(),
        connectionChecker: getIt<ConnectionChecker>(),
      )..add(AuthenticationEvents.checkAuth),
      child: const Appview(),
    );
  }
}

class Appview extends StatelessWidget {
  const Appview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.go(Routes.login);
        } else if (state is Authenticated) {
          context.go(Routes.home);
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
