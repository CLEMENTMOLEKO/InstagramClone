import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/add_media/views/allow_photos_videos_access.dart';
import 'package:instagram_clone_presentation/add_media/widgets/allow_access.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/dependency_injection.dart';

class MockAllowAccessService extends Mock implements AllowAccessService {}

void main() {
  late MockAllowAccessService mockAllowAccessService;

  setUpAll(() {
    mockAllowAccessService = MockAllowAccessService();
    setupDependencyInjection(mockAllowAccessService);
  });

  testWidgets('Should render AllowAccess widget', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: AllowPhotosVideosAccess(),
      ),
    );
    // Act
    // Assert
    expect(find.byType(AllowAccess), findsOneWidget);
  });
}
