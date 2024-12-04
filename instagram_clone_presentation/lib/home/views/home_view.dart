import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_presentation/home/widgets/stories.dart';

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
      body: const SafeArea(
        child: Column(
          children: [
            Gap(8),
            SizedBox(
              height: 80,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [Stories()],
              ),
            ),
            Gap(8),
            Text("Posts"),
          ],
        ),
      ),
    );
  }
}
