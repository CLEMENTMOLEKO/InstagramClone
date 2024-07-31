import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockUser extends Mock implements User {}

void main() {
  final mockUser = MockUser();
  final userModel = UserDtoConstants.userDto
      .toDomainUser()
      .getOrElse(() => throw Exception());
  late MockAuthenticationService mockAuthenticationService;
  late MockUserRepository mockUserRepository;
  late MockConnectionChecker mockConnectionChecker;
  late AuthenticationBloc sut;

  void setupMockUser() {
    when(
      () => mockUser.uid,
    ).thenReturn(Constants.validUuids.first);
  }

  void setupConnectionChecker({bool hasConnection = true}) {
    when(
      () => mockConnectionChecker.hasConnection,
    ).thenAnswer((_) async => hasConnection);
  }

  AuthenticationBloc setupAuthenticationBloc() {
    return AuthenticationBloc(
      authenticationService: mockAuthenticationService,
      userRepository: mockUserRepository,
      connectionChecker: mockConnectionChecker,
    );
  }

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();
    mockConnectionChecker = MockConnectionChecker();

    when(() => mockAuthenticationService.user)
        .thenAnswer((_) => const Stream.empty());
    sut = AuthenticationBloc(
      authenticationService: mockAuthenticationService,
      userRepository: mockUserRepository,
      connectionChecker: mockConnectionChecker,
    );
    setupMockUser();
    setupConnectionChecker();
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
      build: setupAuthenticationBloc,
      expect: () => <AuthenticationState>[UnAuthenticated()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when user is user[not null]',
      setUp: () {
        when(() => mockAuthenticationService.user).thenAnswer(
          (_) => Stream.value(mockUser),
        );
        when(() => mockUserRepository.getUser(userId: any(named: "userId")))
            .thenAnswer((_) async => right(userModel));
      },
      build: setupAuthenticationBloc,
      expect: () => <AuthenticationState>[Authenticated(user: userModel)],
    );

    group("AuthenticationStateChanged", () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationFailed] when user is user but get user returns failure',
        setUp: () {
          when(() => mockAuthenticationService.user).thenAnswer(
            (_) => Stream.value(mockUser),
          );
          when(
            () => mockUserRepository.getUser(userId: any(named: "userId")),
          ).thenAnswer((_) async => left(ApplicationFailure.errorGettingUser));
        },
        build: setupAuthenticationBloc,
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
        build: setupAuthenticationBloc,
        act: (bloc) => bloc.add(SignOutRequested()),
        verify: (_) {
          verify(() => mockAuthenticationService.signOut()).called(1);
        },
      );
    });
  });
}
