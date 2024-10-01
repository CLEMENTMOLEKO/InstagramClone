import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/common/widgets/form_field_view.dart';

import '../../../common/navigation/router.gr.dart';

@RoutePage()
class SignUpUsernameView extends StatelessWidget {
  const SignUpUsernameView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      title: "Create a username",
      subtitle:
          "Add a username or use our suggestion. You can change this at any time",
      fieldLabel: "Username",
      primaryButtonText: "Next",
      onFieldValueChanged: (username) {
        context.read<SignUpBloc>().add(UserNameChanged(username: username));
      },
      getFieldIcon: (state) {
        if (state.usernameInput.isPure) return null;

        return state.isUsernameValid
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.error, color: Colors.red);
      },
      onPrimaryButtonPressed: (_) => () {
        context.router.pushNamed(SignUpBirthdayView.name);
      },
    );
  }
}
