import 'package:flutter/material.dart';

import '../../common/widgets/current_user_profile_button.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child:
              index == 0 ? const CurrentUserProfileButton() : const StoryItem(),
        ),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Colors.grey,
          width: 3,
        ),
        shape: BoxShape.circle,
      ),
      child: const Padding(
        padding: EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: 37,
          backgroundImage: NetworkImage(
            "https://picsum.photos/200/300",
          ),
        ),
      ),
    );
  }
}
