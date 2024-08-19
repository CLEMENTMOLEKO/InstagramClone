import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';

import '../../../common/widgets/gradient_view.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

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
                Text("What's your email address?",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                const Gap(10),
                const Text(
                  "Enter the email address at which you can be contacted. No one will see this on your profile.",
                ),
                const Gap(30),
                const InstaTextField(
                  labelText: "Text label text",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
