import 'package:flutter/material.dart';

import '../../common/widgets/current_user_profile_button.dart';
import '../../common/widgets/story_item.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: index == 0
              ? const CurrentUserProfileButton()
              : const StoryItem(imageUrl: "https://picsum.photos/200/300"),
        ),
      ),
    );
  }
}
