import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_presentation/common/widgets/muted_button.dart';

import '../../common/navigation/router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MutedButton(
        label: "Notifications",
        onPressed: () {
          context.go(Routes.notificationsRoute);
        },
      ),
    );
  }
}
