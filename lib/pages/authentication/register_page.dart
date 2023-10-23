import 'dart:developer';
import 'dart:io';

import 'package:books_log_migration/components/auth_text_formfield.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/pages/authentication/login_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Image.asset("assets/logo_2.png", scale: 6),
              gapH16,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create Account',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: AppColors.text,
                              ),
                    ),
                    TextButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const LoginPage());
                        Navigator.pushReplacement(context, route);
                      },
                      child: const Text(
                        "Already have an account?",
                      ),
                    ),
                  ],
                ),
              ),
              gapH16,
              const Text('Enter your name, email and password to sign up.'),
              gapH24,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primary1,
                        child: photoSet
                            ? Container()
                            : const FaIcon(
                                FontAwesomeIcons.image,
                                size: 40,
                                color: Colors.white,
                              ),
                        backgroundImage: photoSet ? FileImage(imageFile) : null,
                      ),
                    ),
                    gapH16,
                    AuthTextFormField(
                      controller: nameController,
                      label: "Full name",
                      hintText: 'Name',
                      validator: (val) => val!.length < 3
                          ? 'Name must contain at least 3 characters'
                          : null,
                      obscureText: false,
                    ),
                    gapH16,
                    AuthTextFormField(
                      controller: emailController,
                      label: "Email address",
                      hintText: 'Email Address',
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
                      hintText: 'Password',
                      validator: (val) =>
                          val!.length < 6 ? 'Invalid Password' : null,
                      obscureText: true,
                    ),
                    gapH16,
                    AuthTextFormField(
                      controller: cPasswordController,
                      label: "Confirm password",
                      hintText: 'Confirm Password',
                      validator: (val) => val != passwordController.text
                          ? 'Password does not match'
                          : null,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              gapH24,
              ElevatedButton(
                child: const Text(
                  'Register',
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate() && photoSet) {
                          setState(() {
                            isLoading = true;
                          });
                          showLoadingDialog(context);
                          String returnedString = await register(context);
                          setState(() {
                            isLoading = false;
                          });
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
              gapH24,
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
          .whenComplete(() => log('upload complete'));
      await context.read<AuthService>().setProfilePhoto(photoUrl);
      return done;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<void> selectImage() async {
    final XFile? pickedFile =
        (await _picker.pickImage(source: ImageSource.gallery));
    final File file = File(pickedFile!.path);
    setState(() {
      imageFile = file;
      photoSet = true;
    });
  }
}
