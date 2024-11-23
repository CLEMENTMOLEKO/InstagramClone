import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_infrastructure/instagram_clone_infrastructure.dart';

class SignUpPage extends StatelessWidget {
  final AuthenticationService? authenticationService;
  final UserRepository? userRepository;
  final ConnectionChecker? connectionChecker;
  final EmailService? emailService;
  final Widget child;

  const SignUpPage({
    super.key,
    required this.child,
    this.authenticationService,
    this.userRepository,
    this.connectionChecker,
    this.emailService,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        emailService: emailService ?? getIt.get<EmailService>(),
        authenticationService:
            authenticationService ?? getIt.get<AuthenticationService>(),
        userRepository: userRepository ?? getIt.get<UserRepository>(),
        connectionChecker: connectionChecker ?? getIt.get<ConnectionChecker>(),
      ),
      child: BlocListener<SignUpBloc, SignUpState>(
        listenWhen: (previous, current) =>
            previous.formzSubmissionStatus != current.formzSubmissionStatus,
        listener: (context, state) {
          if (state.formzSubmissionStatus == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Something went wrong"),
              ),
            );
          }
          //TODO: Check if this is needed I don't think it is, the stream should take care of this.
          if (state.formzSubmissionStatus == FormzSubmissionStatus.success) {
            context.read<AuthenticationBloc>().add(
                  AuthenticationEvents.checkAuth,
                );
          }
        },
        child: child,
      ),
    );
  }
}
