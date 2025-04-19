import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/add_media/add_media_page.dart';
import 'package:instagram_clone_presentation/add_media/views/allow_photos_videos_access.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/dependency_injection.dart';

class MockAllowAccessService extends Mock implements AllowAccessService {}

void main() {
  late MockAllowAccessService mockAllowAccessService;

  setUpAll(() {
    mockAllowAccessService = MockAllowAccessService();
    setupDependencyInjection(mockAllowAccessService);
  });

  Future<void> pumpAddMediaPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddMediaPage(allowAccessService: mockAllowAccessService),
      ),
    );
  }

  group('AllowPhotosVideosAccess', () {
    Future<void> arrangeForAllowPhotosVideosAccess({
      required WidgetTester tester,
      bool isCameraAndMicrophoneAccessGranted = true,
    }) async {
      when(() => mockAllowAccessService.isCameraAndMicrophoneAccessGranted())
          .thenAnswer((_) async => isCameraAndMicrophoneAccessGranted);
      await pumpAddMediaPage(tester);
      await tester.pumpAndSettle();
    }

    testWidgets(
        'should show AllowAccess widget when user does not have access to camera and microphone',
        (tester) async {
      //Arrange
      await arrangeForAllowPhotosVideosAccess(tester: tester);

      //Act
      //Assert
      expect(find.byType(AllowPhotosVideosAccess), findsNothing);
    });

    testWidgets(
        'should show AllowPhotosVideosAccess widget when user has given access to camera and microphone',
        (tester) async {
      //Arrange
      await arrangeForAllowPhotosVideosAccess(
        tester: tester,
        isCameraAndMicrophoneAccessGranted: false,
      );

      //Act
      //Assert
      expect(find.byType(AllowPhotosVideosAccess), findsOneWidget);
    });
  });
}
