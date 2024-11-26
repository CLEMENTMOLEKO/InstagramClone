import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_scaffold.dart';
import 'package:instagram_clone_presentation/home/widgets/profile_header.dart';

import '../../common/widgets/muted_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return InstaScaffold(
      appBar: InstaAppBar(
        leading: Row(
          children: [
            Text("Username",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const Gap(8),
            const Icon(Icons.arrow_drop_down_sharp),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ProfileHeader(),
              ),
              const SliverGap(8),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: MutedButton(
                        label: "Edit Profile",
                        onPressed: () {},
                      ),
                    ),
                    const Gap(4),
                    Expanded(
                      child: MutedButton(
                        label: "Share Profile",
                        onPressed: () {},
                      ),
                    ),
                    const Gap(4),
                    MutedButtonIcon(
                      icon: Icons.add_circle_rounded,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
