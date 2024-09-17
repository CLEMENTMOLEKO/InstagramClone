import 'package:flutter/material.dart';
import 'package:instagram_clone_presentation/app_themes.dart';

import 'common/navigation/router.dart';

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
