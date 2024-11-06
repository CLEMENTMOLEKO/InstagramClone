import 'package:flutter/material.dart';
import 'package:instagram_clone_presentation/app_themes.dart';
import 'package:instagram_clone_presentation/common/navigation/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: InstagramCloneThemes.light,
      darkTheme: InstagramCloneThemes.dark,
      routerConfig: router,
    );
  }
}
