import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/components/horizontal_list.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/models/my_books.dart';
import 'package:books_log_migration/models/my_reading_list.dart';
import 'package:books_log_migration/pages/book_details_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomSheet extends StatelessWidget {
  final Book book;
  final String documentId;
  const MyBottomSheet({Key? key, required this.book, required this.documentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool alreadyLogged =
        context.watch<MyBooks>().isInMyBooks(book.title, book.author.first);
    bool isInReadingList = context
        .watch<MyReadingList>()
        .isInReadingList(book.title, book.author.first);
    return Container(
      margin: EdgeInsets.all(12),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: writersRow(book.author),
              ),
            ),
            Text(
              book.firstPublishYear.toString(),
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            SizedBox(height: 15),
            GestureDetector(
              child: Text(
                'Go to book',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Route route = MaterialPageRoute(
                  builder: (context) => BookDetailsPage(
                    book: book,
                    documentId: documentId,
                  ),
                );
                Navigator.pop(context);
                Navigator.push(context, route);
              },
            ),
            Divider(),
            alreadyLogged && !isInReadingList
                ? SizedBox(height: 2)
                : Container(),
            alreadyLogged && !isInReadingList
                ? MaterialButton(
                    color: Colors.red,
                    minWidth: double.maxFinite,
                    child: Text('Remove from my books'),
                    onPressed: () {
                      removeBook(context);
                      context
                          .read<MyBooks>()
                          .removeFromMyBooks(book.title, book.author.first);
                      showMessageSnackBar(
                          context, book.title + ' removed from my books');
                      Navigator.pop(context);
                    },
                  )
                : Container(),
            !alreadyLogged && isInReadingList
                ? SizedBox(height: 2)
                : Container(),
            !alreadyLogged && isInReadingList
                ? MaterialButton(
                    color: myBlue,
                    minWidth: double.maxFinite,
                    child: Text('Mark as read'),
                    onPressed: () {
                      removeFromReadingList(context);
                      context
                          .read<MyReadingList>()
                          .removeFromReadingList(book.title, book.author.first);
                      addToBooks(context);
                      context
                          .read<MyBooks>()
                          .addNewToMyBooks(book.title, book.author.first);
                      showMessageSnackBar(
                          context,
                          book.title +
                              ' added to my books\nRemoved from reading list');
                      Navigator.pop(context);
                    },
                  )
                : Container(),
            !alreadyLogged && isInReadingList
                ? SizedBox(height: 2)
                : Container(),
            !alreadyLogged && isInReadingList
                ? MaterialButton(
                    color: Colors.red,
                    minWidth: double.maxFinite,
                    child: Text('Remove from reading list'),
                    onPressed: () {
                      removeFromReadingList(context);
                      context
                          .read<MyReadingList>()
                          .removeFromReadingList(book.title, book.author.first);
                      showMessageSnackBar(
                          context, book.title + ' removed from reading list');
                      Navigator.pop(context);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  String addToBooks(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();

    book.setDateAdded(DateTime.now());
    try {
      firestoreService.uploadBook(book, authService.getCurrentUser().uid);
      return done;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  String removeFromReadingList(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();
    try {
      firestoreService.removeFromReadingList(
          authService.getCurrentUser().uid, documentId);
      return done;
    } catch (e) {
      return e.toString();
    }
  }

  String removeBook(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();
    try {
      firestoreService.removeFromMyBooks(
          authService.getCurrentUser().uid, documentId);
      return done;
    } catch (e) {
      return e.toString();
    }
  }
}
