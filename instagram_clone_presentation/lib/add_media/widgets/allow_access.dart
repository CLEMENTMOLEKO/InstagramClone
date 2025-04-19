import 'package:flutter/cupertino.dart';
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
    return SafeArea(
      child: Column(
        spacing: 16,
        children: [
          Image.asset(imageUrl, height: 160),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center),
          ),
          _RoItem(
            title: "How you'll use this",
            subtitle: howYoullUseThisText,
            icon: CupertinoIcons.photo_fill_on_rectangle_fill,
          ),
          _RoItem(
            title: "How we use this",
            subtitle: howWeUseThisText,
            icon: CupertinoIcons.question_circle_fill,
          ),
          _RoItem(
            title: "How these settings work",
            subtitle:
                "You can change your choices at any time in your device settings. If you allow access now, you won't have to allow it again.",
            icon: CupertinoIcons.gear_alt_fill,
          ),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 34.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: CupertinoColors.systemBlue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Allow access"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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
      mainAxisSize: MainAxisSize.max,
      spacing: 12,
      children: [
        Icon(icon),
        Expanded(
          child: Column(
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
        ),
      ],
    );
  }
}
