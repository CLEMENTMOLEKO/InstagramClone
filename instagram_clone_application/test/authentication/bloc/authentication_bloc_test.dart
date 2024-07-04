import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_utils/constants/constants.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockUser extends Mock implements User {}

void main() {
  final mockUser = MockUser();
  final userModel = UserDtoConstants.userDto
      .toDomainUser()
      .getOrElse(() => throw Exception());
  late MockAuthenticationService mockAuthenticationService;
  late MockUserRepository mockUserRepository;
  late AuthenticationBloc sut;

  void setupMockUser() {
    when(
      () => mockUser.uid,
    ).thenReturn(Constants.validUuids.first);
  }

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();

    when(() => mockAuthenticationService.user)
        .thenAnswer((_) => const Stream.empty());
    sut = AuthenticationBloc(
        authenticationService: mockAuthenticationService,
        userRepository: mockUserRepository);
    setupMockUser();
  });

  group("AuthenticationBloc", () {
    test("Should have Authentication initial when instantiated", () {
      //Arrange
      //Act
      //Assert
      expect(sut.state, AuthenticationInitial());
      sut.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when user is null',
      setUp: () {
        when(() => mockAuthenticationService.user).thenAnswer(
          (_) => Stream.value(null),
        );
      },
      build: () => AuthenticationBloc(
        authenticationService: mockAuthenticationService,
        userRepository: mockUserRepository,
      ),
      expect: () => <AuthenticationState>[UnAuthenticated()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when user is user',
      setUp: () {
        when(() => mockAuthenticationService.user).thenAnswer(
          (_) => Stream.value(mockUser),
        );
        when(() => mockUserRepository.getUser(any()))
            .thenAnswer((_) async => right(userModel));
      },
      build: () => AuthenticationBloc(
        authenticationService: mockAuthenticationService,
        userRepository: mockUserRepository,
      ),
      expect: () => <AuthenticationState>[Authenticated(user: userModel)],
    );

    group("AuthenticationStateChanged", () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationFailed] when user is user but get user returns failure',
        setUp: () {
          when(() => mockAuthenticationService.user).thenAnswer(
            (_) => Stream.value(mockUser),
          );
          when(() => mockUserRepository.getUser(any())).thenAnswer(
              (_) async => left(ApplicationFailure.errorGettingUser));
        },
        build: () => AuthenticationBloc(
          authenticationService: mockAuthenticationService,
          userRepository: mockUserRepository,
        ),
        expect: () => <AuthenticationState>[
          AuthenticationFailed(failure: ApplicationFailure.errorGettingUser)
        ],
      );
    });

    group('SignOutRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'Should call signout on authenticationService'
        'when SignOutRequested is added',
        setUp: () => when(() => mockAuthenticationService.signOut())
            .thenAnswer((_) async => Unit),
        build: () => AuthenticationBloc(
          authenticationService: mockAuthenticationService,
          userRepository: mockUserRepository,
        ),
        act: (bloc) => bloc.add(SignOutRequested()),
        verify: (_) {
          verify(() => mockAuthenticationService.signOut()).called(1);
        },
      );
    });
  });
}
