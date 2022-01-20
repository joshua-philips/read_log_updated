import 'package:books_log_migration/components/book_image.dart';
import 'package:books_log_migration/components/bottom_sheet.dart';
import 'package:books_log_migration/components/horizontal_list.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/pages/book_details_page.dart';
import 'package:flutter/material.dart';

class MyBooksCard extends StatelessWidget {
  final Book book;
  final String documentId;
  const MyBooksCard({Key? key, required this.book, required this.documentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) =>
                BookDetailsPage(book: book, documentId: documentId),
          );
          Navigator.push(context, route);
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            builder: (context) =>
                MyBottomSheet(book: book, documentId: documentId),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            children: [
              BookImage(book: book),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SizedBox(
                        height: 25,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: writersRow(book.author),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
