import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../common/widgets/muted_button.dart';

class ProfileHeaderButtons extends StatelessWidget {
  const ProfileHeaderButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
