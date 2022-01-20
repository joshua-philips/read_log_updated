import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _firebaseAuth.idTokenChanges();

  User getCurrentUser() {
    return _firebaseAuth.currentUser!;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await currentUser.user!.updateDisplayName(name);
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<void> setProfilePhoto(String photoUrl) async {
    await _firebaseAuth.currentUser!.updatePhotoURL(photoUrl);
  }

  Future<void> sendPasswordResetMail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(
      String email, String oldPassword, String newPassword) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }
}
