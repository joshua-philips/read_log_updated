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
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      scale: 3,
                      filterQuality: FilterQuality.none,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Keep track of your books with our exciting app",
                      style: TextStyle(fontSize: 18, color: myGrey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Login Now.",
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
                      "Don\'t have an account? ",
                      style: TextStyle(fontSize: 20, color: myGrey),
                    ),
                    GestureDetector(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => RegisterPage());
                        Navigator.push(context, route);
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
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
                      SizedBox(height: 20),
                      AuthTextFormField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.password,
                        validator: (val) =>
                            val!.isEmpty ? 'Enter password' : null,
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Forgot Password? ",
                            style: TextStyle(fontSize: 20, color: myGrey),
                          ),
                          GestureDetector(
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => PasswordResetPage());
                              Navigator.push(context, route);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
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
      print(e.message);
      return e.message!;
    }
  }
}
