import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  late LoginBloc sut;
  late MockAuthenticationService mockAuthenticationService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    sut = LoginBloc(authenticationService: mockAuthenticationService);
  });

  test(
    "Should have status as [LoginStatus.unknown] when first initialized",
    () {
      //Arrange
      //Act
      //Assert
      expect(sut.state.status, equals(LoginStatus.unknown));
      expect(sut.state.isEmailValid, equals(false));
      expect(sut.state.isPasswordValid, equals(false));
      sut.close();
    },
  );
}
