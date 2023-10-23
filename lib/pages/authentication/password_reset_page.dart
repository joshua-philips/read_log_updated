import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              Text(
                'Reset Password',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.text,
                    ),
              ),
              gapH16,
              const Text(
                "Your password reset link will be sent to the user's email address. Make sure to provide the correct address.",
              ),
              gapH24,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AuthTextFormField(
                      controller: emailController,
                      hintText: 'Email Address',
                      label: "Email address",
                      validator: (val) =>
                          !val!.contains('@') && !val.contains('.')
                              ? 'Invalid Email'
                              : null,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              gapH24,
              ElevatedButton(
                child: const Text('Send reset email'),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          String returnedString = await sendResetEmail(
                              emailController.text, context);
                          setState(() {
                            isLoading = false;
                          });
                          if (returnedString != done) {
                            showMessageDialog(context, 'Error', returnedString);
                          } else {
                            showMessageSnackBar(context,
                                'Password reset email sent. Check your inbox.');
                            Navigator.pop(context);
                          }
                        }
                      },
              ),
              gapH8,
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                ),
                child: const Text(
                  'Cancel',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> sendResetEmail(String email, BuildContext context) async {
    try {
      await context.read<AuthService>().sendPasswordResetMail(email);
      return done;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
