import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/pages/home/profile_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNameDialog extends StatefulWidget {
  const EditNameDialog({Key? key}) : super(key: key);

  @override
  _EditNameDialogState createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthService>().getCurrentUser();
    return AlertDialog(
      title: const Text("Update name"),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AuthTextFormField(
                controller: nameController,
                label: "Enter name",
                hintText: user.displayName!,
                validator: (val) => val!.length < 3
                    ? 'Name must contain at least 3 characters'
                    : null,
                obscureText: false,
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              Route route =
                  MaterialPageRoute(builder: (context) => const ProfilePage());
              await user.updateDisplayName(nameController.text);
              Navigator.pop(context);
              Navigator.pushReplacement(context, route);
            }
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}
