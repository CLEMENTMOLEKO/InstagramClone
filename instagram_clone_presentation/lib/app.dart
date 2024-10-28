import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/authentication/authentication_service.dart';
import 'package:instagram_clone_application/authentication/bloc/authentication_bloc.dart';
import 'package:instagram_clone_application/common/network/connection_checker.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:instagram_clone_infrastructure/dependency_injection.dart';
import 'package:instagram_clone_presentation/app_themes.dart';
import 'package:instagram_clone_presentation/authentication/authentication_page.dart';
import 'package:instagram_clone_presentation/home/home_page.dart';

import 'common/navigation/router.dart';
import 'common/navigation/router.gr.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: InstagramCloneThemes.light,
      darkTheme: InstagramCloneThemes.dark,
      routerConfig: _appRouter.config(),
    );
  }
}

@RoutePage()
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationService: getIt<AuthenticationService>(),
        userRepository: getIt<UserRepository>(),
        connectionChecker: getIt<ConnectionChecker>(),
      )..add(
          AuthenticationStatusChecked()), //TODO: Trigger initial authentication check adding an event the bloc can handle
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
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
      ),
    );
  }
}
