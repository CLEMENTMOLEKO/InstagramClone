import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_infrastructure/network/connection_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late ConnectionCheckerImpl sut;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    sut = ConnectionCheckerImpl(
        internetConnectionChecker: mockInternetConnectionChecker);
  });

  test(
    "Should return true when [InternetConncetionChecker.hasConnection] returns true",
    () async {
      //Arrange
      final hasConnectionFuture = Future.value(true);
      when(
        () => mockInternetConnectionChecker.hasConnection,
      ).thenAnswer((_) async => hasConnectionFuture);
      //Act
      final result = await sut.hasConnection;
      //Assert
      verify(
        () => mockInternetConnectionChecker.hasConnection,
      ).called(1);
      expect(result, true);
    },
  );

  test(
    "Should return false when [InternetConncetionChecker.hasConnection] returns false",
    () async {
      //Arrange
      final hasConnectionFuture = Future.value(false);
      when(
        () => mockInternetConnectionChecker.hasConnection,
      ).thenAnswer((_) async => hasConnectionFuture);
      //Act
      final result = await sut.hasConnection;
      //Assert
      verify(
        () => mockInternetConnectionChecker.hasConnection,
      ).called(1);
      expect(result, false);
    },
  );
}
