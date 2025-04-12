import 'package:flutter/material.dart';

import '../widgets/allow_access.dart';

class AllowPhotosVideosAccess extends StatelessWidget {
  const AllowPhotosVideosAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: AllowAccess(
          title: "Allow Instagram to access your camera and microphone",
          imageUrl: "assets/images/allow_photos_videos_access.png",
          howYoullUseThisText:
              """To take photos, record videos, and preview visual and audio effects""",
          howWeUseThisText: "To show you previews of visual and audio effects",
        ),
      ),
    );
  }
}
