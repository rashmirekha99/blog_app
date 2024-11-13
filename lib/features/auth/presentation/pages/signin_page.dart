import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();

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
              'Sign In',
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
            GradientButton(
              buttonText: "Sign In",
              onPress: () {},
            ),
            SizedBox(height: screenHeight * 0.03),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                          text: 'Sign up',
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
