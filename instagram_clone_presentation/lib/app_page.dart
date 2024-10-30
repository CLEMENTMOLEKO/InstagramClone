import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

import 'authentication/authentication_page.dart';
import 'common/navigation/router.gr.dart';
import 'home/home_page.dart';

@RoutePage()
class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationService: getIt<AuthenticationService>(),
        userRepository: getIt<UserRepository>(),
        connectionChecker: getIt<ConnectionChecker>(),
      ),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.router.replace(const AuthenticationRoute());
        } else if (state is Authenticated) {
          context.router.replace(const HomeRoute());
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return switch (state) {
            AuthenticationInitial() => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Unauthenticated() => const AuthenticationPage(),
            Authenticated(user: _) => const HomePage(),
            _ => const Scaffold(
                body: Center(
                  child: Text("Error occurred"),
                ),
              ),
          };
        },
      ),
    );
  }
}
