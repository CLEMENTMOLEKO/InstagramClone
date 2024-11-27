import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_scaffold.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_header_buttons.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return InstaScaffold(
      appBar: InstaAppBar(
        leading: Row(
          children: [
            Text(
              "Username",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            const Icon(Icons.arrow_drop_down_sharp),
          ],
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ProfileHeader(),
              ),
              SliverGap(8),
              SliverToBoxAdapter(
                child: ProfileHeaderButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
