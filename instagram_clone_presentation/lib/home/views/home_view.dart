import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_presentation/common/widgets/muted_button.dart';

import '../../common/navigation/router.dart';
import '../../common/widgets/insta_scaffold.dart';
import '../widgets/logo_font.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InstaScaffold(
      appBar: InstaAppBar(
        leading: const LogoFont(),
        trailing: [
          IconButton(
            onPressed: () => context.go(Routes.notificationsRoute),
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          const Gap(4),
          IconButton(
            onPressed: () => context.go(Routes.shareRoute),
            icon: const Icon(Icons.send_outlined),
          ),
        ],
      ),
      body: Center(
        child: MutedButton(
          label: "Notifications",
          onPressed: () {
            context.go(Routes.notificationsRoute);
          },
        ),
      ),
    );
  }
}
