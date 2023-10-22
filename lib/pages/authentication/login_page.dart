import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/pages/authentication/password_reset_page.dart';
import 'package:books_log_migration/pages/authentication/register_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/logo_2.png", scale: 6),
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.text,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const RegisterPage());
                      Navigator.pushReplacement(context, route);
                    },
                    child: const Text("Don't have account?"),
                  ),
                ],
              ),
              gapH16,
              const Text('Enter your email and password to sign in.'),
              gapH24,
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextFormField(
                      controller: emailController,
                      label: "Email address",
                      hintText: 'Email address',
                      validator: (val) =>
                          !val!.contains('@') && !val.contains('.')
                              ? 'Invalid Email'
                              : null,
                      obscureText: false,
                    ),
                    gapH16,
                    AuthTextFormField(
                      controller: passwordController,
                      label: "Password",
                      hintText: 'Enter password',
                      validator: (val) =>
                          val!.isEmpty ? 'Enter password' : null,
                      obscureText: true,
                    ),
                    gapH24,
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          String returnedString = await login(
                              emailController.text,
                              passwordController.text,
                              context);
                          if (returnedString != done) {
                            showMessageDialog(
                                context, 'Login Error', returnedString);
                          } else {
                            Navigator.popUntil(
                                context, (route) => !Navigator.canPop(context));
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => const PasswordResetPage());
                    Navigator.push(context, route);
                  },
                  child: const Text('Forgot password?'),
                ),
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }

  Future<String> login(
      String email, String password, BuildContext context) async {
    try {
      await context
          .read<AuthService>()
          .loginWithEmailAndPassword(email, password);
      return done;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
