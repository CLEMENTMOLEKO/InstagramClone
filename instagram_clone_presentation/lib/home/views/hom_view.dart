import 'package:flutter/material.dart';

import '../../common/widgets/insta_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstaScaffold(
      appBar: InstaAppBar(
        leading: Text("Home"),
      ),
      body: Center(child: Text("Home")),
    );
  }
}
