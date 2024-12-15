import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double borderWidth;
  const StoryItem({
    super.key,
    required this.imageUrl,
    this.radius = 37,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Colors.grey,
          width: borderWidth,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
