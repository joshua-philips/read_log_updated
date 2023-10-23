import 'package:books_log_migration/components/book_image.dart';
import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/components/horizontal_list.dart';
import 'package:books_log_migration/components/list_section.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/models/my_books.dart';
import 'package:books_log_migration/models/my_reading_list.dart';
import 'package:books_log_migration/pages/home/my_books_page.dart';
import 'package:books_log_migration/pages/home/reading_list_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

/// Complete view containing all the book details to display and buttons
/// based on the location of the book in firestore (Reading List or My Books)
class BookDetails extends StatefulWidget {
  final Book book;
  final bool newBook;
  final String documentId;
  const BookDetails({
    Key? key,
    required this.book,
    required this.newBook,
    required this.documentId,
  }) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late TextEditingController reviewController;

  @override
  void initState() {
    super.initState();
    reviewController = TextEditingController(text: widget.book.review);
  }

  @override
  Widget build(BuildContext context) {
    bool alreadyLogged = context.watch<MyBooks>().isInMyBooks(widget.book.title,
        widget.book.author.isNotEmpty ? widget.book.author.first : "");
    bool isInReadingList = context.watch<MyReadingList>().isInReadingList(
        widget.book.title,
        widget.book.author.isNotEmpty ? widget.book.author.first : "");
    return Scrollbar(
      thickness: 2,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          gapH8,
          topView(context, alreadyLogged, isInReadingList, widget.newBook),
          gapH16,
          widget.book.summary.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      gapH8,
                      ExpandableText(
                        widget.book.summary,
                        expandText: 'Read more',
                        collapseText: 'Show less',
                        maxLines: 5,
                        linkColor: AppColors.text,
                      )
                    ],
                  ),
                )
              : Container(),
          widget.book.subject.isNotEmpty
              ? ListSection(
                  sectionTitle: 'Subjects',
                  children: horizontalDetailList(widget.book.subject),
                )
              : Container(),
          widget.book.place.isNotEmpty
              ? ListSection(
                  sectionTitle: 'Places',
                  children: horizontalDetailList(widget.book.place),
                )
              : Container(),
          widget.book.time.isNotEmpty
              ? ListSection(
                  sectionTitle: 'Time',
                  children: horizontalDetailList(widget.book.time),
                )
              : Container(),
          widget.book.person.isNotEmpty
              ? ListSection(
                  sectionTitle: 'Character',
                  children: horizontalDetailList(widget.book.person),
                )
              : Container(),
          widget.book.publisher.isNotEmpty
              ? ListSection(
                  sectionTitle: 'Publishers',
                  children: horizontalDetailList(widget.book.publisher),
                )
              : Container(),
          widget.book.publishYear.isNotEmpty
              ? ListSection(
                  sectionTitle: 'Years Published',
                  children: horizontalDetailListSorted(widget.book.publishYear),
                )
              : Container(),
          widget.book.links.isNotEmpty
              ? ListSection(
                  sectionTitle: 'External Links',
                  children: listOfLinks(widget.book.links, context),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notes',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 4,
                  controller: reviewController,
                  scrollPhysics: const BouncingScrollPhysics(),
                  decoration: const InputDecoration(
                    hintText: "Enter related notes",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          gapH20,
          widget.newBook && !alreadyLogged && !isInReadingList
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ElevatedButton(
                    child: const Text('Add to my books'),
                    onPressed: () {
                      addToBooks(context);
                      context.read<MyBooks>().addNewToMyBooks(
                          widget.book.title,
                          widget.book.author.isNotEmpty
                              ? widget.book.author.first
                              : "");
                      showMessageSnackBar(
                          context, widget.book.title + ' added to my books');
                    },
                  ),
                )
              : Container(),
          !isInReadingList && widget.newBook && alreadyLogged
              ? gapH8
              : Container(),
          !isInReadingList && widget.newBook && alreadyLogged
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ElevatedButton(
                    child: const Text('In my books. Go to My Books'),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const MyBooksPage());
                      Navigator.push(context, route);
                    },
                  ),
                )
              : Container(),
          !isInReadingList && !alreadyLogged && widget.newBook
              ? gapH8
              : Container(),
          !isInReadingList && !alreadyLogged && widget.newBook
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: OutlinedButton(
                    child: const Text('Add to reading list'),
                    onPressed: () {
                      addToReadingList(context);
                      context.read<MyReadingList>().addNewToReadingList(
                          widget.book.title,
                          widget.book.author.isNotEmpty
                              ? widget.book.author.first
                              : "");
                      showMessageSnackBar(context,
                          widget.book.title + ' added to reading list');
                    },
                  ),
                )
              : Container(),
          isInReadingList && widget.newBook && !alreadyLogged
              ? gapH8
              : Container(),
          isInReadingList && widget.newBook && !alreadyLogged
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: OutlinedButton(
                    child: const Text('In reading list. Go to Reading List'),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const ReadingListPage());
                      Navigator.push(context, route);
                    },
                  ),
                )
              : Container(),
          !widget.newBook ? const SizedBox(height: 2) : Container(),
          !widget.newBook
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.success),
                    child: const Text('Update Notes & Review'),
                    onPressed: () {
                      if (reviewController.text.compareTo(widget.book.review) !=
                          0) {
                        updateBook(context, alreadyLogged);
                        showMessageSnackBar(
                            context, widget.book.title + ' updated');
                        Navigator.pop(context);
                      } else {
                        showMessageSnackBar(
                            context, 'No change in your notes/review');
                      }
                    },
                  ),
                )
              : Container(),
          alreadyLogged && !widget.newBook ? gapH8 : Container(),
          alreadyLogged && !widget.newBook
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                    ),
                    child: const Text('Remove from my books'),
                    onPressed: () {
                      removeBook(context);
                      context.read<MyBooks>().removeFromMyBooks(
                          widget.book.title,
                          widget.book.author.isNotEmpty
                              ? widget.book.author.first
                              : "");
                      showMessageSnackBar(context,
                          widget.book.title + ' removed from my books');
                      Navigator.pop(context);
                    },
                  ),
                )
              : Container(),
          !alreadyLogged && isInReadingList && !widget.newBook
              ? gapH8
              : Container(),
          !alreadyLogged && isInReadingList && !widget.newBook
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ElevatedButton(
                    child: const Text('Mark as read'),
                    onPressed: () {
                      removeFromReadingList(context);
                      context.read<MyReadingList>().removeFromReadingList(
                          widget.book.title,
                          widget.book.author.isNotEmpty
                              ? widget.book.author.first
                              : "");
                      addToBooks(context);
                      context.read<MyBooks>().addNewToMyBooks(
                          widget.book.title,
                          widget.book.author.isNotEmpty
                              ? widget.book.author.first
                              : "");
                      showMessageSnackBar(
                          context,
                          widget.book.title +
                              ' added to my books\nRemoved from reading list');
                      Navigator.pop(context);
                    },
                  ),
                )
              : Container(),
          !alreadyLogged && isInReadingList && !widget.newBook
              ? gapH8
              : Container(),
          !alreadyLogged && isInReadingList && !widget.newBook
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error),
                    child: const Text('Remove from reading list'),
                    onPressed: () {
                      removeFromReadingList(context);
                      context.read<MyReadingList>().removeFromReadingList(
                          widget.book.title,
                          widget.book.author.isNotEmpty
                              ? widget.book.author.first
                              : "");
                      showMessageSnackBar(context,
                          widget.book.title + ' removed from reading list');
                      Navigator.pop(context);
                    },
                  ),
                )
              : Container(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget topView(BuildContext context, bool alreadyLogged, bool isInReadingList,
      bool newBook) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                writersColumn(context),
                widget.book.firstPublishYear > 0
                    ? Text(
                        widget.book.firstPublishYear.toString(),
                      )
                    : Container(),
                Text(
                  widget.book.publisher.isNotEmpty
                      ? widget.book.publisher.first
                      : '',
                ),
                gapH16,
                Row(
                  children: [
                    widget.newBook && !alreadyLogged && !isInReadingList
                        ? MaterialButton(
                            color: AppColors.primary2,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            ),
                            elevation: 0,
                            onPressed: () {
                              addToBooks(context);
                              context.read<MyBooks>().addNewToMyBooks(
                                  widget.book.title,
                                  widget.book.author.isNotEmpty
                                      ? widget.book.author.first
                                      : "");
                              showMessageSnackBar(context,
                                  widget.book.title + ' added to my books');
                            },
                            child: const Text("Add to books"),
                          )
                        : Container(),
                    !isInReadingList && widget.newBook && alreadyLogged
                        ? MaterialButton(
                            color: AppColors.primary2,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            ),
                            elevation: 0,
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => const MyBooksPage());
                              Navigator.push(context, route);
                            },
                            child: const Text("Go to books"),
                          )
                        : Container(),
                    alreadyLogged && !widget.newBook
                        ? MaterialButton(
                            color: AppColors.primary2,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            ),
                            elevation: 0,
                            onPressed: () {
                              removeBook(context);
                              context.read<MyBooks>().removeFromMyBooks(
                                  widget.book.title,
                                  widget.book.author.isNotEmpty
                                      ? widget.book.author.first
                                      : "");
                              showMessageSnackBar(context,
                                  widget.book.title + ' removed from my books');
                              Navigator.pop(context);
                            },
                            child: const Text("Remove book"),
                          )
                        : Container(),
                    gapW4,
                    !isInReadingList && !alreadyLogged && widget.newBook
                        ? IconButton(
                            onPressed: () {
                              addToReadingList(context);
                              context.read<MyReadingList>().addNewToReadingList(
                                  widget.book.title,
                                  widget.book.author.isNotEmpty
                                      ? widget.book.author.first
                                      : "");
                              showMessageSnackBar(context,
                                  widget.book.title + ' added to reading list');
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.bookmark,
                              color: AppColors.primary2,
                            ),
                          )
                        : Container(),
                    isInReadingList && widget.newBook && !alreadyLogged
                        ? GestureDetector(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) =>
                                      const ReadingListPage());
                              Navigator.push(context, route);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.solidBookmark,
                              color: AppColors.primary2,
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
          gapW8,
          BookImageToDialog(book: widget.book),
        ],
      ),
    );
  }

  Column writersColumn(BuildContext context) {
    List<Widget> writers = [];

    if (widget.book.author.isNotEmpty) {
      for (int count = 0; count < widget.book.author.length; count++) {
        writers.add(
          Text(
            widget.book.author[count],
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.text),
          ),
        );
      }
    } else {
      writers.add(Text(
        'Unknown',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.text),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: writers,
    );
  }

  String addToBooks(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();
    if (reviewController.text.isNotEmpty) {
      widget.book.updateReview(reviewController.text);
    }
    widget.book.setDateAdded(DateTime.now());

    try {
      firestoreService.uploadBook(
          widget.book, authService.getCurrentUser().uid);
      return done;
    } catch (e) {
      return e.toString();
    }
  }

  String addToReadingList(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();
    if (reviewController.text.isNotEmpty) {
      widget.book.updateReview(reviewController.text);
    }
    widget.book.setDateAdded(DateTime.now());

    try {
      firestoreService.uploadToReadingList(
          widget.book, authService.getCurrentUser().uid);
      return done;
    } catch (e) {
      return e.toString();
    }
  }

  String updateBook(BuildContext context, bool alreadyLogged) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();

    try {
      widget.book.updateReview(reviewController.text);
      firestoreService.updateBookReview(
          alreadyLogged,
          authService.getCurrentUser().uid,
          widget.documentId,
          reviewController.text);
      return done;
    } catch (e) {
      return e.toString();
    }
  }

  String removeFromReadingList(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    FirestoreService firestoreService = context.read<FirestoreService>();
    try {
      firestoreService.removeFromReadingList(
          authService.getCurrentUser().uid, widget.documentId);
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
          authService.getCurrentUser().uid, widget.documentId);
      return done;
    } catch (e) {
      return e.toString();
    }
  }
}
