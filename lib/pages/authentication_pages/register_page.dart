import 'dart:io';

import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/blue_button.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final _picker = ImagePicker();
  late File imageFile;
  bool photoSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: CircleAvatar(
                          radius: 60,
                          child: photoSet
                              ? Container()
                              : Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 40,
                                ),
                          backgroundImage:
                              photoSet ? FileImage(imageFile) : null,
                        ),
                      ),
                      SizedBox(height: 15),
                      AuthTextFormField(
                        controller: nameController,
                        hintText: 'Name',
                        prefixIcon: Icons.person,
                        validator: (val) => val!.length < 3
                            ? 'Name must contain at least 3 characters'
                            : null,
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
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
                      SizedBox(height: 15),
                      AuthTextFormField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.password,
                        validator: (val) =>
                            val!.length < 6 ? 'Invalid Password' : null,
                        obscureText: true,
                      ),
                      SizedBox(height: 15),
                      AuthTextFormField(
                        controller: cPasswordController,
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.password,
                        validator: (val) => val != passwordController.text
                            ? 'Password does not match'
                            : null,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: BlueButton(
                  buttonText: 'Register',
                  onPressed: () async {
                    if (formKey.currentState!.validate() && photoSet) {
                      showLoadingDialog(context);
                      String returnedString = await register(context);
                      if (returnedString != done) {
                        Navigator.pop(context);
                        showMessageDialog(context, 'Error', returnedString);
                      } else {
                        Navigator.popUntil(
                            context, (route) => !Navigator.canPop(context));
                      }
                    } else if (photoSet == false) {
                      showMessageDialog(context, 'No profile picture',
                          'Please select a profile photo');
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 20, color: Color(0xff757575)),
                  ),
                  GestureDetector(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> register(BuildContext context) async {
    try {
      await context.read<AuthService>().createUserWithEmailAndPassword(
            emailController.text,
            passwordController.text,
            nameController.text,
          );
      String photoUrl = await context
          .read<StorageService>()
          .uploadProfilePhoto(imageFile, emailController.text)
          .whenComplete(() => print('upload complete'));
      await context.read<AuthService>().setProfilePhoto(photoUrl);
      return done;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> selectImage() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    final File file = File(pickedFile!.path);
    setState(() {
      imageFile = file;
      photoSet = true;
    });
  }
}
