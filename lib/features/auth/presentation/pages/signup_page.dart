import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.05),
            AuthField(
              hintText: 'name',
              controller: nameController,
            ),
            SizedBox(height: screenHeight * 0.03),
            AuthField(
              hintText: 'email',
              controller: emailController,
            ),
            SizedBox(height: screenHeight * 0.03),
            AuthField(
              hintText: 'password',
              controller: passwordController,
              isObscureTExt: true,
            ),
            SizedBox(height: screenHeight * 0.03),
            GradientButton(
              buttonText: "Sign Up",
              onPress: () {
                if (formKey.currentState!.validate()) {
                  
                  context.read<AuthBloc>().add(AuthSignUp(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()));
                }
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                          text: 'Sign in',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppPalette.gradient2))
                    ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
