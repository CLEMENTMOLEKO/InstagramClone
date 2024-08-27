import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

import 'common/navigation/route_generator.dart';
import 'common/navigation/route_names.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(
            authenticationService: getIt.get<AuthenticationService>(),
            userRepository: getIt.get<UserRepository>(),
            connectionChecker: getIt.get<ConnectionChecker>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        initialRoute: RouteNames.signUp,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
