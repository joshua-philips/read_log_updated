import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/blue_button.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 90),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Your password reset link will be sent to the user's email address.\nMake sure to provide the correct address.",
                  style: TextStyle(fontSize: 20, color: myGrey),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlueButton(
                  buttonText: 'Send Reset Email',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String returnedString =
                          await sendResetEmail(emailController.text, context);
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  color: Colors.red,
                  minWidth: double.maxFinite,
                  height: 45,
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
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
      print(e.message);
      return e.message!;
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }
}
