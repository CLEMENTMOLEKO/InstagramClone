import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';

class SignUpSaveLoginInfoView extends StatelessWidget {
  const SignUpSaveLoginInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.read<SignUpBloc>().state.formzSubmissionStatus ==
        FormzSubmissionStatus.inProgress;

    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      key: const Key("form_field_view"),
      title: "Save your login info?",
      subtitle:
          "We'll save the login info for your new account, so you won't need to enter it next time you log in.",
      primaryButtonText: "Save",
      onPrimaryButtonPressed: (_) => onPrimaryButtonPressed(context),
      fieldLabel: "",
      showTextField: false,
      secondaryButtonText: "Not now",
      onSecondaryButtonPressed: () => context.go('/home'),
        showProgressIndicator: isLoading);
  }

  VoidCallback? onPrimaryButtonPressed(BuildContext context) {
    return () {
      // Handle saving login info
      context.read<SignUpBloc>().add(SignUpEvents.signUp);
    };
  }
}
