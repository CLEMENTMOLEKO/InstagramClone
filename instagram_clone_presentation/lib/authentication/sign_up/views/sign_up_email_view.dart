import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';

import '../../../common/navigation/route_names.dart';
import '../../../common/widgets/form_field_view.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      buildWhen: (previous, current) =>
          previous.emailInput != current.emailInput,
      onFieldValueChanged: (email) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(email: email));
      },
      getErrorText: _getErrorText,
      title: "What's your email address?",
      subtitle:
          "Enter the email address at which you can be contacted. No one will see this on your profile.",
      fieldLabel: "Email Address",
      primaryButtonText: "Next",
      onPrimaryButtonPressed: (state) => _onPrimaryButtonPressed(
        state,
        context,
      ),
      secondaryButtonText: "Sign Up with Mobile Number",
      onSecondaryButtonPressed: () {},
      getFieldIcon: _getFieldIcon,
    );
  }
}

VoidCallback? _onPrimaryButtonPressed(SignUpState state, BuildContext context) {
  return state.emailInput.isValid
      ? () => Navigator.pushNamed(
            context,
            RouteNames.signUpEmailVerification,
          )
      : null;
}

String? _getErrorText(SignUpState state) {
  if (state.emailInput.isPure ||
      state.formzSubmissionStatus == FormzSubmissionStatus.initial) {
    return null;
  }

  return state.emailInput.isNotValid ? "Invalid email address" : null;
}

Icon? _getFieldIcon(SignUpState state) {
  if (state.emailInput.isPure) return null;

  return state.emailInput.isNotValid
      ? const Icon(Icons.error, color: Colors.red)
      : const Icon(Icons.check_circle, color: Colors.green);
}
