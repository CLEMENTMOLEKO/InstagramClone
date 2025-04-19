import 'package:flutter/material.dart';

import '../widgets/allow_access.dart';

class AllowPhotosVideosAccess extends StatelessWidget {
  const AllowPhotosVideosAccess({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Can we use svg and change color of svg
    final imageUrl =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? "assets/images/allowaccesstocameramicdark.png"
            : "assets/images/allowaccesstocameramiclight.png";
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(28.0),
        child: AllowAccess(
          title: "Allow Instagram to access your camera and microphone",
          imageUrl: imageUrl,
          howYoullUseThisText:
              """To take photos, record videos, and preview visual and audio effects""",
          howWeUseThisText: "To show you previews of visual and audio effects",
        ),
      ),
    );
  }
}
