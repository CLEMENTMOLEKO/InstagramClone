import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:meta/meta.dart';

import '../../../common/email/email_service.dart';
import '../../../common/network/connection_checker.dart';
import '../../authentication.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService authenticationService;
  final UserRepository userRepository;
  final ConnectionChecker connectionChecker;
  final EmailService emailService;

  SignUpBloc({
    required this.authenticationService,
    required this.userRepository,
    required this.connectionChecker,
    required this.emailService,
  }) : super(const SignUpState()) {
    on<SignUpRequested>(_signUpRequested);
    on<SignUpEmailChanged>(_signUpEmailChanged);
    on<SignUpPasswordChanged>(_signUpPasswordChanged);
    on<UserNameChanged>(_userNameChanged);
    on<SingUpEmailVerificationRequested>(_signUpEmailVerificationRequested);
    on<VerifySignUpCodeRequested>(_verifySignUpCodeRequested);
  }

  Future<void> _signUpRequested(
    SignUpRequested event,
    Emitter<SignUpState> emit,
  ) async {
    if (!state.isValid) return;

    if (!await connectionChecker.hasConnection) {
      return emit(state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.canceled));
    }

    emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress));
    await _registerWithEmailAndPassword(
        state.emailInput.value, state.passwordInput.value, emit);
  }

  void _signUpEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    final emailInput = EmailInput.dirty(value: event.email);
    emit(state.copyWith(
      emailInput: emailInput,
      isValid: Formz.validate([emailInput, state.passwordInput]),
    ));
  }

  void _signUpPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final passwordInput = PasswordInput.dirty(value: event.password);
    emit(state.copyWith(
      passwordInput: passwordInput,
      isValid: Formz.validate([passwordInput, state.emailInput]),
    ));
  }

  void _userNameChanged(
    UserNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(userName: event.userName));
  }

  void _signUpEmailVerificationRequested(
    SingUpEmailVerificationRequested event,
    Emitter<SignUpState> emit,
  ) async {
    final code = emailService.generateVerificationCode();
    await emailService.sendVerificationCodeToEmail(
      email: event.email,
      code: code,
    );
    emit(state.copyWith(verificationCode: code));
  }

  void _verifySignUpCodeRequested(
    VerifySignUpCodeRequested event,
    Emitter<SignUpState> emit,
  ) {
    if (state.verificationCode == int.parse(event.code)) {
      emit(state.copyWith(isEmailVerified: true));
    }
  }

  Future<void> _registerWithEmailAndPassword(
    String email,
    String password,
    Emitter<SignUpState> emit,
  ) async {
    final createEmailResult = EmailAddress.create(email: email);
    final createPasswordResult = Password.create(password: password);
    if (createEmailResult.isRight() && createPasswordResult.isRight()) {
      final emailAddress = createEmailResult.getOrElse(() => throw Exception(
          "Error occured using email address to register user"));
      final registerResult =
          await authenticationService.registerWithEmailAndPassword(
        emailAddress: emailAddress,
        password: createPasswordResult.getOrElse(() =>
            throw Exception("Error occured using password to register user")),
      );

      registerResult.fold(
        (failure) => emit(state.copyWith(
            formzSubmissionStatus: FormzSubmissionStatus.failure)),
        (userId) {
          _addUserToFirebaseUserDb(userId, emailAddress);

          emit(
            state.copyWith(
                formzSubmissionStatus: FormzSubmissionStatus.success),
          );
        },
      );
    } else {
      emit(
          state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _addUserToFirebaseUserDb(
    String uid,
    EmailAddress emailAddres,
  ) async {
    final userModel = UserModel.createUser(
        userId: UserId.create(value: uid)
            .getOrElse(() => throw Exception("Error creating user")),
        userName: state.userName,
        bio: "",
        avatarUrl: "",
        emailAddress: emailAddres,
        joined: DateTime.now());

    await userRepository.addUser(
      userModel: userModel
          .getOrElse(() => throw Exception("Error creating userModel")),
    );
  }
}
