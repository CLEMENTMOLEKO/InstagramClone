import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class InteractiveText extends StatelessWidget {
  final List<TextSpan> textSpans;
  final bool useDefaultSpacing;

  const InteractiveText({
    super.key,
    required this.textSpans,
    this.useDefaultSpacing = true,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> finalSpans =
        useDefaultSpacing ? _getFinalSpans() : textSpans;

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: finalSpans,
      ),
    );
  }

  List<TextSpan> _getFinalSpans() {
    List<TextSpan> finalSpans = [];
    for (int i = 0; i < textSpans.length; i++) {
      finalSpans.add(textSpans[i]);

      // Add a space after each TextSpan if useDefaultSpacing is true
      // and it's not the last TextSpan
      if (i < textSpans.length - 1) {
        finalSpans.add(const TextSpan(text: ' '));
      }
    }
    return finalSpans;
  }
}

class ClickableTextSpan extends TextSpan {
  ClickableTextSpan({
    required String text,
    required VoidCallback onTap,
    TextStyle? style,
  }) : super(
          text: text,
          style: style ??
              const TextStyle(
                color: CupertinoColors.activeBlue,
              ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        );
}
