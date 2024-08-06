import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.lerp(
            Colors.pink,
            Colors.deepPurple,
            5,
          )!,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Center(
          child: Container(
            color: Theme.of(context).colorScheme.surfaceTint,
            child: Text("Test scaffold"),
          ),
        ),
      ),
    );
  }
}
