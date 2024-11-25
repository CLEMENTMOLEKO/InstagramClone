import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(
              "http://via.placeholder.com/350x150",
            ),
          ),
        ),
        _buildProfileStatsCount(
          context: context,
          count: "0",
          label: "Posts",
        ),
        _buildProfileStatsCount(
          context: context,
          count: "0",
          label: "Followers",
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _buildProfileStatsCount(
            context: context,
            count: "0",
            label: "Following",
          ),
        ),
      ],
    );
  }

  Widget _buildProfileStatsCount({
    required BuildContext context,
    required String count,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
