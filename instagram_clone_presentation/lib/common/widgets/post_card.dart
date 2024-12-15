import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import 'story_item.dart';

class PostCard extends StatelessWidget {
  final PostDto post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //TODO: Add user profile image via bloc or cubit for posts.
              const StoryItem(
                imageUrl: "https://picsum.photos/200/300",
                radius: 15,
                borderWidth: 1.5,
              ),
              const Gap(10),
              Expanded(
                child: Text(post.description),
              ),
              const Gap(10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.red,
          child: Image.network(
            post.imageUrls.first,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
