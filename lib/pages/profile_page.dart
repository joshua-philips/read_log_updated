import 'package:books_log_migration/components/edit_name_dialog.dart';
import 'package:books_log_migration/components/my_drawer.dart';
import 'package:books_log_migration/pages/my_books_page.dart';
import 'package:books_log_migration/pages/profile_photo_page.dart';
import 'package:books_log_migration/pages/reading_list_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthService>().getCurrentUser();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(user.displayName!),
        elevation: 0,
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white.withOpacity(0.4),
            ),
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => EditNameDialog());
            },
            icon: Icon(Icons.edit),
            label: Text('Change Name'),
          ),
        ],
      ),
      drawer: MyDrawer(currentPage: CurrentPage.PROFILE),
      body: Scrollbar(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(user.photoURL!),
                      radius: 60,
                      onForegroundImageError: (exception, stackTrace) =>
                          Text(user.displayName![0]),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => ProfilePhotoPage(
                                photoUrl: user.photoURL!,
                              ));
                      Navigator.push(context, route);
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    user.email!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 0),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Books Logged',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Spacer(),
                    StreamBuilder(
                      stream: context
                          .read<FirestoreService>()
                          .myBooksStream(user.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.docs.length.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (context) => MyBooksPage());
                Navigator.push(context, route);
              },
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Reading List',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Spacer(),
                    StreamBuilder(
                      stream: context
                          .read<FirestoreService>()
                          .readingListStream(user.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.docs.length.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (context) => ReadingListPage());
                Navigator.push(context, route);
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            //   child: Row(
            //     children: [
            //       Text(
            //         'All Books',
            //         style: TextStyle(
            //           fontSize: 17,
            //           color: Colors.white.withOpacity(0.7),
            //         ),
            //       ),
            //       Spacer(),
            //       Text(
            //         numberOfAllBooks.toString(),
            //         style: TextStyle(
            //           fontSize: 17,
            //           color: Colors.white.withOpacity(0.4),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
