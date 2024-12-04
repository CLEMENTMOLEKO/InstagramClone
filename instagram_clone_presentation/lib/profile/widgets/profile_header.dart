import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../common/widgets/current_user_profile_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            children: [
              const CurrentUserProfileButton(),
              const Gap(8),
              Text("Username",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildProfileStatsCount(
            context: context,
            count: "0",
            label: "Posts",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildProfileStatsCount(
            context: context,
            count: "0",
            label: "Followers",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 8),
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
