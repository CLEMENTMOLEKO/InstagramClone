import 'package:flutter/material.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_scaffold.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstaScaffold(
      body: Center(
        child: Text("Notifications View."),
      ),
    );
  }
}
