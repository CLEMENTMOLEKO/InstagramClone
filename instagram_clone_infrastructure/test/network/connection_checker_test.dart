import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_infrastructure/network/connection_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late ConnectionChecker sut;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    sut = ConnectionChecker(
        internetConnectionChecker: mockInternetConnectionChecker);
  });

  test(
    "Should return the same future instance returned by [InternetConncetionChecker.hasConnection]",
    () {
      //Arrange
      final hasConnectionFuture = Future.value(true);
      when(
        () => mockInternetConnectionChecker.hasConnection,
      ).thenAnswer((_) async => hasConnectionFuture);
      //Act
      final result = sut.hasConnection;
      //Assert
      verify(
        () => mockInternetConnectionChecker.hasConnection,
      ).called(1);
      expect(result, hasConnectionFuture);
    },
  );
}
