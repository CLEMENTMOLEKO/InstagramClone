import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';

import 'gradient_view.dart';

class FormFieldView<Tbloc extends Bloc<TEvent, TState>, TEvent, TState>
    extends StatelessWidget {
  final String title;
  final String subtitle;
  final String fieldLabel;
  final String primaryButtonText;
  final VoidCallback? Function(TState) onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool Function(TState, TState) buildWhen;
  final void Function(String) onChanged;
  final String? Function(TState) getErrorText;

  const FormFieldView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fieldLabel,
    required this.primaryButtonText,
    required this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    required this.buildWhen,
    required this.onChanged,
    required this.getErrorText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Gap(10),
                Text(subtitle),
                const Gap(30),
                BlocBuilder<Tbloc, TState>(
                  buildWhen: buildWhen,
                  builder: (context, state) {
                    return Column(
                      children: [
                        InstaTextField(
                          labelText: fieldLabel,
                          onChanged: onChanged,
                          errorText: getErrorText(state),
                        ),
                        const Gap(20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: const Key("form_field_view_primary_button"),
                            onPressed: onPrimaryButtonPressed(state),
                            child: Text(primaryButtonText),
                          ),
                        )
                      ],
                    );
                  },
                ),
                if (secondaryButtonText != null) const Gap(10),
                if (secondaryButtonText != null)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      key: const Key("form_field_view_secondary_button"),
                      onPressed: onSecondaryButtonPressed,
                      child: Text(secondaryButtonText!),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
