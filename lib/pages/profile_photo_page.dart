import 'dart:io';

import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
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
        title: Text('Profile photo'),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              selectImage();
            },
            icon: Icon(Icons.edit_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          photoSet
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  child: Image.network(
                    widget.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
          Spacer(),
          MaterialButton(
            color: Colors.green,
            onPressed: () async {
              if (photoSet) {
                showLoadingDialog(context);
                try {
                  await uploadImage(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                } on Exception catch (e) {
                  Navigator.pop(context);
                  showMessageDialog(
                      context, 'Change failed', 'Error: ' + e.toString());
                }
                Navigator.pop(context);
              } else {
                showMessageSnackBar(context, 'Photo not changed');
              }
            },
            child: Text('Save'),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> uploadImage(BuildContext context) async {
    final User user = context.read<AuthService>().getCurrentUser();
    String photoUrl = await context
        .read<StorageService>()
        .uploadProfilePhoto(imageFile, user.email!)
        .whenComplete(() => print('upload complete'));
    await context.read<AuthService>().setProfilePhoto(photoUrl);
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
