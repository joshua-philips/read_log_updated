import 'package:books_log_migration/components/book_image.dart';
import 'package:books_log_migration/components/bottom_sheet.dart';
import 'package:books_log_migration/components/horizontal_list.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/pages/book_details_page.dart';
import 'package:flutter/material.dart';

class MyBooksCard extends StatelessWidget {
  final Book book;
  final String documentId;
  final bool hideImage;
  const MyBooksCard({
    Key? key,
    required this.book,
    required this.documentId,
    this.hideImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultBorderRadius),
                topRight: Radius.circular(defaultBorderRadius),
              ),
            ),
            builder: (context) =>
                MyBottomSheet(book: book, documentId: documentId),
          );
        },
        child: Row(
          children: [
            hideImage ? Container() : BookImage(book: book),
            hideImage ? Container() : gapW8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: writersRow(book.author),
                    ),
                  ),
                  Text(book.firstPublishYear.toString()),
                  Text(book.publisher.isNotEmpty ? book.publisher.first : "")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
