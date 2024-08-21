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
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isValid) {
          Navigator.pushNamed(context, RouteNames.signUpEmailVerification);
        }
      },
      child: FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
        buildWhen: (previous, current) =>
            previous.emailInput != current.emailInput,
        onChanged: (email) {
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
      ),
    );
  }
}

VoidCallback? _onPrimaryButtonPressed(SignUpState state, BuildContext context) {
  return state.emailInput.isValid
      ? () {
          context
              .read<SignUpBloc>()
              .add(SignUpRequested(userName: state.emailInput.value));
        }
      : null;
}

String? _getErrorText(SignUpState state) {
  return state.emailInput.isNotValid &&
          !state.emailInput.isPure &&
          state.formzSubmissionStatus != FormzSubmissionStatus.initial
      ? "Invalid email address"
      : null;
}
