import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

void main() {
  test("Should be equal when two states with same values are compared", () {
    //Arrange
    const loginState1 = LoginState();
    const loginState2 = LoginState();
    //Act
    //Assert
    expect(loginState1, loginState2);
  });
}
