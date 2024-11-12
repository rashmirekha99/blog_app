import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey=GlobalKey<FormState>();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.05),
            const AuthField(hintText: 'name'),
            SizedBox(height: screenHeight * 0.03),
            const AuthField(hintText: 'email'),
            SizedBox(height: screenHeight * 0.03),
            const AuthField(hintText: 'name'),
            SizedBox(height: screenHeight * 0.03),
            const GradientButton(),
            SizedBox(height: screenHeight * 0.03),
            RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                        text: 'Sign in',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppPalette.gradient2))
                  ]),
            )
          ],
        ),
      ),
    ));
  }
}
