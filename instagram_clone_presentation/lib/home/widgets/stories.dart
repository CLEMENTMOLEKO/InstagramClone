import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context, index) => const StoryItem(),
          ),
        ),
      ],
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.grey,
        ),
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
            "https://picsum.photos/200/300",
          ),
        ),
      ],
    );
  }
}
