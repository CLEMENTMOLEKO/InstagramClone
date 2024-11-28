import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstaScaffold extends StatelessWidget {
  final Widget body;
  final InstaAppBar? appBar;
  const InstaScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoScaffold(context)
        : _buildMaterialScaffold(context);
  }

  Widget _buildCupertinoScaffold(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar != null
          ? CupertinoNavigationBar(
              backgroundColor: appBar!.backgroundColor,
              border: appBar!.border ?? Border.all(color: Colors.transparent),
              leading: appBar!.leading,
              middle: appBar!.middle,
              trailing: appBar!.trailing != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: appBar!.trailing!,
                    )
                  : null,
            )
          : null,
      child: body,
    );
  }

  Widget _buildMaterialScaffold(BuildContext context) {
    return Scaffold(
      appBar: appBar != null
          ? AppBar(
              leading: appBar!.leading,
              title: appBar!.middle,
              actions: appBar!.trailing != null ? [...appBar!.trailing!] : [],
            )
          : null,
      body: body,
    );
  }
}

class InstaAppBar {
  final Widget? leading;
  final Widget? middle;
  final List<Widget>? trailing;
  final Color? backgroundColor;
  final Border? border;
  const InstaAppBar({
    this.leading,
    this.middle,
    this.trailing,
    this.backgroundColor = Colors.transparent,
    this.border,
  });
}
