import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogoFont extends StatelessWidget {
  const LogoFont({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/Instagram_logo.png",
          height: 64,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const Gap(4),
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 32,
        ),
      ],
    );
  }
}
