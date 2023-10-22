import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.text,
              ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AuthTextFormField(
                  controller: oldPasswordController,
                  label: "Enter old password",
                  hintText: 'Old Password',
                  validator: (val) => val!.isEmpty ? 'Enter password' : null,
                  obscureText: true,
                ),
                gapH16,
                AuthTextFormField(
                  controller: newPasswordController,
                  label: "Enter new password",
                  hintText: 'New Password',
                  validator: (val) =>
                      val!.length < 6 ? 'Invalid Password' : null,
                  obscureText: true,
                ),
                gapH16,
                AuthTextFormField(
                  controller: confirmPasswordController,
                  label: "Confirm new password",
                  hintText: 'Confirm Password',
                  validator: (val) => val != newPasswordController.text
                      ? 'Password does not match'
                      : null,
                  obscureText: true,
                ),
                gapH24,
                ElevatedButton(
                  child: const Text('Update Password'),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String returnedString = await updatePassword(context);
                      if (returnedString == done) {
                        showMessageSnackBar(context, 'Password updated');
                        Navigator.pop(context);
                      } else {
                        showMessageDialog(context, 'Error', returnedString);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> updatePassword(BuildContext context) async {
    String email = context.read<AuthService>().getCurrentUser().email!;
    try {
      await context.read<AuthService>().changePassword(email,
          oldPasswordController.text.trim(), newPasswordController.text.trim());
      return done;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
