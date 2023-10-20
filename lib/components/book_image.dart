import 'package:books_log_migration/components/bottom_sheet.dart';
import 'package:books_log_migration/components/image_dialog.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/pages/book_details_page.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

/// Grid Image to be displlayed by stream. Displays book details
/// when tap
class MyBooksImage extends StatelessWidget {
  final Book book;
  final String documentId;
  final bool isImageOnly;
  const MyBooksImage(
      {Key? key,
      required this.book,
      required this.documentId,
      this.isImageOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => NetworkImageDialog(
            imageUrl: book.coverImage,
            imageTitle: book.title,
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          builder: (context) =>
              MyBottomSheet(book: book, documentId: documentId),
        );
      },
      onTap: () {
        Route route = MaterialPageRoute(
          builder: (context) => BookDetailsPage(
            book: book,
            documentId: documentId,
          ),
        );
        Navigator.push(context, route);
      },
      child: Column(
        children: [
          Container(
            height: isImageOnly ? 180 : 170,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
              border: Border.all(
                color: Colors.white70,
              ),
              color: AppColors.primary1,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
              child: Image.network(book.coverImage,
                  fit: BoxFit.fill,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) => child,
                  errorBuilder: (context, error, stackTrace) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            book.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          book.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          isImageOnly
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextScroll(
                              book.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                              intervalSpaces: 10,
                              velocity: const Velocity(
                                  pixelsPerSecond: Offset(10, 0)),
                              fadedBorder: true,
                              fadeBorderVisibility: FadeBorderVisibility.auto,
                              fadeBorderSide: FadeBorderSide.both,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

/// Displays cover image in book details. Shows image dialog on tap
class BookImageToDialog extends StatelessWidget {
  final Book book;
  const BookImageToDialog({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => NetworkImageDialog(
            imageUrl: book.coverImage,
            imageTitle: book.title,
          ),
        );
      },
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: Colors.white70,
          ),
          color: Colors.black54,
        ),
        child: Image.network(book.coverImage,
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                child,
            errorBuilder: (context, error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      book.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    book.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
      ),
    );
  }
}

/// Normal book image with no functionality apart from displaying
/// book cover. Used in Card in Listview
class BookImage extends StatelessWidget {
  final Book book;
  const BookImage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
        border: Border.all(
          color: Colors.white70,
        ),
        color: AppColors.primary1,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
        child: Image.network(book.coverImage,
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                child,
            errorBuilder: (context, error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      book.title,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    book.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
