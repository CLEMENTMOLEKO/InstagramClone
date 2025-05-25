import 'package:flutter/cupertino.dart';
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
        leading: GestureDetector(
          onTapDown: (TapDownDetails details) async {
            final overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;

            showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy,
                overlay.size.width - details.globalPosition.dx,
                overlay.size.height - details.globalPosition.dy,
              ),
              items: [
                PopupMenuItem(
                  value: 'following',
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.person_outline_rounded),
                      Text('Following'),
                    ],
                  ),
                  onTap: () => print('navigate to following'),
                ),
                PopupMenuItem(
                  value: 'favourite',
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.favorite_border_rounded),
                      Text('Favourite'),
                    ],
                  ),
                  onTap: () => print('navigate to favourite'),
                ),
              ],
              shadowColor: Colors.transparent,
              color: CupertinoColors.systemBackground,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: CupertinoColors.separator.resolveFrom(context),
                  width: 0,
                ),
              ),
            );
          },
          child: LogoFont(),
        ),
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
        child: SingleChildScrollView(
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
      ),
    );
  }
}
