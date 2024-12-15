import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/home/widgets/stories.dart';

import '../../common/navigation/router.dart';
import '../../common/widgets/insta_scaffold.dart';
import '../../common/widgets/post_card.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const Gap(8),
            const SizedBox(
              height: 80,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [Stories()],
              ),
            ),
            const Gap(8),
            PostCard(
              post: PostDto(
                id: "aoeifo23ir2fn3",
                userId: "aoeifo23ir2fn4",
                description: "Description",
                imageUrls: const ["https://picsum.photos/200/300"],
                date: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
