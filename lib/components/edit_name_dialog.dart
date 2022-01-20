import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/pages/profile_page.dart';
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
      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      title: Text('Enter Name'),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AuthTextFormField(
                  controller: nameController,
                  hintText: user.displayName!,
                  prefixIcon: Icons.person,
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
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.green,
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.green,
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              Route route =
                  MaterialPageRoute(builder: (context) => ProfilePage());
              await user.updateDisplayName(nameController.text);
              Navigator.pop(context);
              Navigator.pushReplacement(context, route);
            }
          },
          child: Text('SAVE'),
        ),
      ],
    );
  }
}
