import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/common/navigation/router.gr.dart';
import '../widget_helpers/get_field_icon.dart';
import '../../../common/widgets/form_field_view.dart';

@RoutePage()
class SignUpPasswordView extends StatelessWidget {
  const SignUpPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldView<SignUpBloc, SignUpEvent, SignUpState>(
      title: "Create a password",
      subtitle:
          "Create a password with at least 6 letters or numbers, It should be something others can't guess",
      fieldLabel: "Password",
      primaryButtonText: "Next",
      onFieldValueChanged: (password) {
        context
            .read<SignUpBloc>()
            .add(SignUpPasswordChanged(password: password));
      },
      onPrimaryButtonPressed: (state) => _onPrimaryButtonPressed(
        state,
        context,
      ),
      getFieldIcon: (state) => getFieldIcon(state.passwordInput),
    );
  }

  VoidCallback? _onPrimaryButtonPressed(
      SignUpState state, BuildContext context) {
    return state.passwordInput.isValid
        ? () {
            context.router.pushNamed(SignUpUsernameView.name);
          }
        : null;
  }
}
