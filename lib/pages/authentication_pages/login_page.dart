import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/blue_button.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/pages/authentication_pages/register_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'password_reset_page.dart';

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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Login now.",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 20, color: myGrey),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const RegisterPage());
                        Navigator.pushReplacement(context, route);
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        controller: emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icons.email,
                        validator: (val) =>
                            !val!.contains('@') && !val.contains('.')
                                ? 'Invalid Email'
                                : null,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      AuthTextFormField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.password,
                        validator: (val) =>
                            val!.isEmpty ? 'Enter password' : null,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Forgot Password? ",
                            style: TextStyle(fontSize: 20, color: myGrey),
                          ),
                          GestureDetector(
                            child: const Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordResetPage());
                              Navigator.push(context, route);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(20),
                child: BlueButton(
                  buttonText: "Login",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String returnedString = await login(emailController.text,
                          passwordController.text, context);
                      if (returnedString != done) {
                        showMessageDialog(
                            context, 'Login Error', returnedString);
                      } else {
                        Navigator.popUntil(
                            context, (route) => !Navigator.canPop(context));
                      }
                    }
                  },
                ),
              ),
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
