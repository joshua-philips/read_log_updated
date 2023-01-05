import 'dart:developer';

import 'package:books_log_migration/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadBook(Book book, String uid) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('books')
        .add(book.toJson())
        .catchError((error) => error);
  }

  Stream<QuerySnapshot> myBooksStream(String uid) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('books')
        .orderBy('dateAdded', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> uploadToReadingList(Book book, String uid) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('readingList')
        .add(book.toJson())
        .catchError((error) => error);
  }

  Stream<QuerySnapshot> readingListStream(String uid) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('readingList')
        .orderBy('dateAdded', descending: false)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> removeFromReadingList(String uid, String documentId) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('readingList')
        .doc(documentId)
        .delete()
        .catchError((error) => error);
  }

  Future<void> removeFromMyBooks(String uid, String documentId) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('books')
        .doc(documentId)
        .delete()
        .catchError((error) => error);
  }

  Future<void> updateBookReview(
      bool inBooks, String uid, String documentId, String review) {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection(inBooks ? 'books' : 'readingList')
        .doc(documentId)
        .update({'review': review}).catchError((error) => log('ERROR: $error'));
  }
}
