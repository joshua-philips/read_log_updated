import 'package:books_log_migration/components/book_image.dart';
import 'package:books_log_migration/components/my_books_card.dart';
import 'package:books_log_migration/components/my_drawer.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/configuration/grid_settings.dart';
import 'package:books_log_migration/models/book.dart';
import 'package:books_log_migration/models/my_books.dart';
import 'package:books_log_migration/pages/search_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({Key? key}) : super(key: key);

  @override
  _MyBooksPageState createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthService>().getCurrentUser();
    return Scaffold(
      drawer: const MyDrawer(currentPage: CurrentPage.MY_BOOKS),
      body: Scrollbar(
        thickness: 2,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: const Text('My Books'),
              actions: [
                IconButton(
                  icon: Icon(context.watch<GridSettings>().myBooksGrid
                      ? Icons.view_list_rounded
                      : Icons.view_array_rounded),
                  onPressed: () {
                    context.read<GridSettings>().toggleMyBooksGrid();
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
                          .myBooksStream(user.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: const Center(
                                child: Text('Oops! Something went wrong')),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
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
          Route route =
              MaterialPageRoute(builder: (context) => const SearchPage());
          Navigator.push(context, route);
        },
      ),
    );
  }

  Widget body(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    if (context.watch<GridSettings>().myBooksGrid) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          Book book = Book.fromJson(data);
          context.read<MyBooks>().addToMyBooks(book.title, book.author.first);
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
          context.read<MyBooks>().addToMyBooks(book.title, book.author.first);
          return MyBooksCard(book: book, documentId: document.id);
        }).toList(),
      );
    }
  }
}

class NoBooks extends StatelessWidget {
  const NoBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            scale: 3,
            filterQuality: FilterQuality.none,
          ),
          const SizedBox(height: 15),
          Text(
            'No books added',
            style: TextStyle(color: myGrey, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
