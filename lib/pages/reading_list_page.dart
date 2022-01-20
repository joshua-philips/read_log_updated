import 'package:books_log_migration/components/book_image.dart';
import 'package:books_log_migration/components/my_books_card.dart';
import 'package:books_log_migration/components/my_drawer.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/configuration/grid_settings.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/models/my_reading_list.dart';
import 'package:books_log_migration/pages/search_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      drawer: MyDrawer(currentPage: CurrentPage.READING_LIST),
      body: Scrollbar(
        thickness: 2,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text('Reading List'),
              actions: [
                IconButton(
                  icon: Icon(context.watch<GridSettings>().readingListGrid
                      ? Icons.view_list_rounded
                      : Icons.view_array_rounded),
                  onPressed: () {
                    context.read<GridSettings>().toggleReadingListGrid();
                  },
                )
              ],
              elevation: 0,
              floating: true,
              backgroundColor: Colors.transparent,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: context
                          .read<FirestoreService>()
                          .readingListStream(user.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(
                                child: Text('Oops! Something went wrong')),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          return snapshot.data!.docs.length > 0
                              ? body(snapshot, context)
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child: Center(
                                    child: Text(
                                      'No books in reading list',
                                      style: TextStyle(
                                          color: myGrey, fontSize: 18),
                                    ),
                                  ),
                                );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        mini: true,
        child: Icon(Icons.add, color: Colors.white.withOpacity(0.7)),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => SearchPage());
          Navigator.push(context, route);
        },
      ),
    );
  }

  Widget body(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    if (context.watch<GridSettings>().readingListGrid) {
      return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
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
        physics: NeverScrollableScrollPhysics(),
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
