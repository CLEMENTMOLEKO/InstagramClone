import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_presentation/common/widgets/interactive_text.dart';

void main() {
  late InteractiveText sut;

  setUp(() {
    sut = const InteractiveText(textSpans: [
      TextSpan(text: "Hello"),
      TextSpan(text: "World"),
    ]);
  });

  Future<void> renderInteractiveText({
    required WidgetTester widgetTester,
    bool useDefaultSpacing = true,
  }) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: InteractiveText(
        useDefaultSpacing: useDefaultSpacing,
        textSpans: const [
          TextSpan(text: "Hello"),
          TextSpan(text: "World"),
        ],
      ),
    ));
  }

  group("Interactive text", () {
    testWidgets("Should render interactive text with space between text spans",
        (WidgetTester widgetTester) async {
      // Arrange
      await renderInteractiveText(widgetTester: widgetTester);
      // Act
      final richText = find.byType(RichText);
      final richTextWidget = widgetTester.widget<RichText>(richText);
      final parentTextSpanChildren =
          (richTextWidget.text as TextSpan).children as List<TextSpan>;
      // Assert
      expect(richText, findsOneWidget);
      expect(parentTextSpanChildren[1].text, " ");
    });

    testWidgets(
        "Should render interactive text with no space between text spans when useDefaultSpacing is false",
        (WidgetTester widgetTester) async {
      // Arrange
      await renderInteractiveText(
          widgetTester: widgetTester, useDefaultSpacing: false);
      // Act
      final richText = find.byType(RichText);
      final richTextWidget = widgetTester.widget<RichText>(richText);
      final parentTextSpanChildren =
          (richTextWidget.text as TextSpan).children as List<TextSpan>;
      // Assert
      expect(richText, findsOneWidget);
      expect(parentTextSpanChildren[1].text, "World");
    });
  });
}
