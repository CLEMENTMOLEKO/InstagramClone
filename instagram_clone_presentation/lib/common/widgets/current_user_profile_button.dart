import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentUserProfileButton extends StatelessWidget {
  const CurrentUserProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(
              "https://picsum.photos/200/300",
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.add_circle_rounded,
              color: CupertinoColors.link,
            ),
          ),
        ],
      ),
    );
  }
}
