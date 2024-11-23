import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

import 'common/navigation/router.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  const AppPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationService: getIt<AuthenticationService>(),
        userRepository: getIt<UserRepository>(),
        connectionChecker: getIt<ConnectionChecker>(),
      )..add(AuthenticationEvents.checkAuth),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go(Routes.signUpEmailPath);
          } else if (state is Authenticated) {
            context.go(Routes.home);
          }
          print("state: $state");
        },
        child: child,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
          child: CircularProgressIndicator(),
      ),
    );
  }
}
