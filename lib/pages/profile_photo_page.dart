import 'dart:developer';
import 'dart:io';

import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePhotoPage extends StatefulWidget {
  final String photoUrl;
  const ProfilePhotoPage({Key? key, required this.photoUrl}) : super(key: key);

  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  final _picker = ImagePicker();
  late File imageFile;
  bool photoSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile photo'),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              selectImage();
            },
            icon: Icon(
              Icons.edit_rounded,
              color: AppColors.inputfieldBg,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          photoSet
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  child: Image.network(
                    widget.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
          const Spacer(),
          MaterialButton(
            color: AppColors.inputfieldBg,
            onPressed: () async {
              if (photoSet) {
                showLoadingDialog(context);
                try {
                  await uploadImage(context);
                  Navigator.pop(context);
                  showMessageSnackBar(context, 'Photo changed successfully');
                } on Exception catch (e) {
                  Navigator.pop(context);
                  showMessageDialog(
                      context, 'Change failed', 'Error: ' + e.toString());
                }
              } else {
                showMessageSnackBar(context, 'Photo not changed');
              }
            },
            child: const Text('Save'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> uploadImage(BuildContext context) async {
    final User user = context.read<AuthService>().getCurrentUser();
    String photoUrl = await context
        .read<StorageService>()
        .uploadProfilePhoto(imageFile, user.email!)
        .whenComplete(() => log('upload complete'));
    await context.read<AuthService>().setProfilePhoto(photoUrl);
  }

  Future<void> selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    final File file = File(pickedFile!.path);
    setState(() {
      imageFile = file;
      photoSet = true;
    });
  }
}
