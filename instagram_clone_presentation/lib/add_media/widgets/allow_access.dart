import 'package:flutter/material.dart';

class AllowAccess extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String howYoullUseThisText;
  final String howWeUseThisText;

  const AllowAccess({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.howYoullUseThisText,
    required this.howWeUseThisText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
        ),
        _RoItem(
          title: "How you'll use this",
          subtitle: howYoullUseThisText,
          icon: Icons.check_circle,
        ),
        _RoItem(
          title: "How we use this",
          subtitle: howWeUseThisText,
          icon: Icons.check_circle,
        ),
        _RoItem(
          title: "How these settings work",
          subtitle:
              """You can change your choices at any time in your device settings.
              If you allow access now, you won't have to allow it again.""",
          icon: Icons.check_circle,
        ),
      ],
    );
  }
}

class _RoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _RoItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Icon(icon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          spacing: 2,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
