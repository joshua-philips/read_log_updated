import 'package:books_log_migration/components/book_image.dart';
import 'package:books_log_migration/components/my_books_card.dart';
import 'package:books_log_migration/components/search_container.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/configuration/grid_settings.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/models/my_reading_list.dart';
import 'package:books_log_migration/pages/home/my_books_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ReadingListPage extends StatefulWidget {
  const ReadingListPage({Key? key}) : super(key: key);

  @override
  _ReadingListPageState createState() => _ReadingListPageState();
}

class _ReadingListPageState extends State<ReadingListPage> {
  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthService>().getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reading List',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.text,
              ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: FaIcon(
              context.watch<GridSettings>().readingListGrid
                  ? FontAwesomeIcons.gripLines
                  : FontAwesomeIcons.grip,
              color: AppColors.primary2,
            ),
            onPressed: () {
              context.read<GridSettings>().toggleReadingListGrid();
            },
          ),
        ],
      ),
      body: Scrollbar(
        thickness: 2,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              gapH8,
              const SearchContaner(),
              gapH16,
              StreamBuilder<QuerySnapshot>(
                stream: context
                    .read<FirestoreService>()
                    .readingListStream(user.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(
                          child: Text('Oops! Something went wrong')),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    return snapshot.data!.docs.isNotEmpty
                        ? body(snapshot, context)
                        : const NoBooks();
                  } else {
                    return Container();
                  }
                },
              ),
              gapH24,
            ],
          ),
        ),
      ),
    );
  }

  Widget body(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    if (context.watch<GridSettings>().readingListGrid) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 3,
        childAspectRatio: 0.55,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          Book book = Book.fromJson(data);
          context
              .read<MyReadingList>()
              .addToReadingList(book.title, book.author.first);
          return MyBooksImage(
            book: book,
            documentId: document.id,
          );
        }).toList(),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          Book book = Book.fromJson(data);
          context
              .read<MyReadingList>()
              .addToReadingList(book.title, book.author.first);
          return MyBooksCard(book: book, documentId: document.id);
        }).toList(),
      );
    }
  }
}
