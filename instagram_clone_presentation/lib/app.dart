import 'package:flutter/material.dart';

import 'common/navigation/route_generator.dart';
import 'common/navigation/route_names.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
