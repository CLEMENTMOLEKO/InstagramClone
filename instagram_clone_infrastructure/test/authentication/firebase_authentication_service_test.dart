import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/authentication/firebase_authentication_service.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUser extends Mock implements User {}

void main() {
  late FirebaseAuthenticationService sut;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFirebaseAuth mockFirebaseAuth;

  final EmailAddress emailAddress =
      EmailAddress.create(email: "bafanaskoana@gmail.com")
          .getOrElse(() => throw Exception("Invalid Email"));
  final Password password = Password.create(password: "P@ssword123")
      .getOrElse(() => throw Exception("Invalid Password"));

  setUpAll(() {
    registerFallbackValue(const AuthCredential(
      providerId: "provideId",
      signInMethod: "email",
    ));
  });
  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseAuth = MockFirebaseAuth();
    sut = FirebaseAuthenticationService(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
  });

  group("LogInWithEmailAndPassword", () {
    test("Should return unit when authenticatioin is successful", () async {
      //Arrange
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => MockUserCredential());
      //Act
      final result = await sut.loginWithEmailAndPassword(
          emailAddress: emailAddress, password: password);
      //Assert
      verify(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailAddress.value,
          password: password.value,
        ),
      );
      expect(result, right(unit));
    });

    test("Should return Authfailure when authenticatioin is unsuccessful",
        () async {
      //Arrange
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenThrow(FirebaseAuthException(code: "invalid-email"));
      //Act
      final result = await sut.loginWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      //Assert
      verify(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailAddress.value,
          password: password.value,
        ),
      );
      expect(result, left(AuthFailure.invalidPasswordAndEmailCombination));
    });
  });

  group("RegisterWithEmailAndPassword", () {
    test("Should return Uuid when authenticatioin is successful", () async {
      //Arrange
      final mockUserCredential = MockUserCredential();
      final fakeUser = MockUser();
      when(
        () => fakeUser.uid,
      ).thenReturn(Constants.validUuids.first);
      when(
        () => mockUserCredential.user,
      ).thenReturn(fakeUser);
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => mockUserCredential);
      //Act
      final result = await sut.registerWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      //Assert
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: emailAddress.value,
            password: password.value,
          ));
      expect(result, right(Constants.validUuids.first));
    });

    test("Should return AuthFailure when authenticatioin is unsuccessful",
        () async {
      //Arrange
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenThrow(FirebaseAuthException(code: "email-already-in-use"));
      //Act
      final result = await sut.registerWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      //Assert
      verify(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailAddress.value,
          password: password.value,
        ),
      );
      expect(result, left(AuthFailure.emailAlreadyInUse));
    });
  });

  group("SignInWithGoogle", () {
    final mockGoogleSignInAccount = MockGoogleSignInAccount();
    final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    void arrangeSignInWithGoogle() {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((_) async => mockGoogleSignInAccount);
      when(() => mockGoogleSignInAccount.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn("");
      when(() => mockGoogleSignInAuthentication.accessToken).thenReturn("");
    }

    test('Should return unit when login is successful', () async {
      //Arrange
      arrangeSignInWithGoogle();
      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => MockUserCredential());
      //Act
      final result = await sut.signInWithGoogle();
      //Assert
      verify(() => mockGoogleSignIn.signIn());
      verify(() => mockFirebaseAuth.signInWithCredential(any()));
      expect(result, right(unit));
    });

    test(
      "Should return Failure when login is unsuccessful"
      "and the user cancelled login",
      () async {
        //Arrange
        when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => null);
        //Act
        final result = await sut.signInWithGoogle();
        //Assert
        expect(result, left(AuthFailure.userCancelledLogin));
      },
    );

    test(
      "Should return Failure when sign in with credentials failed"
      "but google signIn is successfull",
      () async {
        //Arrange
        arrangeSignInWithGoogle();
        when(() => mockFirebaseAuth.signInWithCredential(any()))
            .thenThrow(FirebaseAuthException(code: "invalid-credential"));
        //Act
        final result = await sut.signInWithGoogle();
        //Assert
        expect(result, left(AuthFailure.invalidCredentials));
      },
    );
  });

  group("SignOut", () {
    test("Should call the firebase auth signOut", () async {
      //Arrange
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => Unit);
      //Act
      await sut.signOut();
      //Assert
      verify(() => mockFirebaseAuth.signOut());
    });
  });
}
