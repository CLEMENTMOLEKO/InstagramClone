import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/add_media/widgets/allow_access.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/dependency_injection.dart';

class MockAllowAccessService extends Mock implements AllowAccessService {}

void main() {
  late MockAllowAccessService mockAllowAccessService;
  setUpAll(() {
    // Mock the allowAccessService
    mockAllowAccessService = MockAllowAccessService();
    setupDependencyInjection(mockAllowAccessService);
  });

  testWidgets('Should open settings when user taps on Allow access button',
      (tester) async {
    //Arrange
    when(() => mockAllowAccessService.requestAccessToCameraAndMicInSettings())
        .thenAnswer((_) async {});
    await tester.pumpWidget(MaterialApp(
      home: AllowAccess(
        title: 'title',
        imageUrl: 'assets/images/allowaccesstocameramicdark.png',
        howYoullUseThisText: 'howYoullUseThisText',
        howWeUseThisText: 'howWeUseThisText',
      ),
    ));

    //Act
    await tester.tap(find.byKey(const Key('allow_access_button')));

    //Assert
    verify(() => mockAllowAccessService.requestAccessToCameraAndMicInSettings())
        .called(1);
  });
}
