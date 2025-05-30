import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/dependency_injection.dart';

import 'views/allow_photos_videos_access.dart';

class AddMediaPage extends StatefulWidget {
  final AllowAccessService allowAccessService;

  AddMediaPage({super.key, AllowAccessService? allowAccessService})
      : allowAccessService = allowAccessService ?? getIt<AllowAccessService>();

  @override
  State<AddMediaPage> createState() => _AddMediaPageState();
}

class _AddMediaPageState extends State<AddMediaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //Guard with mounted to avoid using BuildContext accross async gaps.
      if (!(await hasAccessToVideosAndPhotos()) && mounted) {
        showCupertinoSheet(
          context: context,
          pageBuilder: (context) => const AllowPhotosVideosAccess(),
        );
      }
    });
  }

  Future<bool> hasAccessToVideosAndPhotos() async {
    return await widget.allowAccessService.isCameraAndMicrophoneAccessGranted();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () {},
          child: Icon(
            CupertinoIcons.xmark,
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
        ),
        middle: Text(
          "New post",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Text(
            "Next",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      child: const Column(
        children: [
          Text("Add Media"),
        ],
      ),
    );
  }
}
