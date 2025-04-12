import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'views/allow_photos_videos_access.dart';

class AddMediaPage extends StatefulWidget {
  const AddMediaPage({super.key});

  @override
  State<AddMediaPage> createState() => _AddMediaPageState();
}

class _AddMediaPageState extends State<AddMediaPage> {
  @override
  void initState() {
    super.initState();
    if (!hasAccessToVideosAndPhotos()) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showCupertinoSheet(
          context: context,
          pageBuilder: (context) => const AllowPhotosVideosAccess(),
        );
      });
    }
  }

  bool hasAccessToVideosAndPhotos() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(child: Text("Add Media")),
    );
  }
}
