import 'package:flutter/material.dart';

import '../widgets/allow_access.dart';

class AllowPhotosVideosAccess extends StatelessWidget {
  const AllowPhotosVideosAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(28.0),
        child: AllowAccess(
          title: "Allow Instagram to access your camera and microphone",
          imageUrl: "assets/images/allowaccesstocameramic.png",
          howYoullUseThisText:
              """To take photos, record videos, and preview visual and audio effects""",
          howWeUseThisText: "To show you previews of visual and audio effects",
        ),
      ),
    );
  }
}
