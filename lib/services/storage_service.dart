import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePhoto(File image, String fileName) async {
    UploadTask uploadTask =
        _storage.ref().child('$fileName.jpg').putFile(image);

    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print('Upload Complete'));

    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> removePhoto(String fileName) async {
    return _storage.ref().child('$fileName.jpg').delete();
  }
}
