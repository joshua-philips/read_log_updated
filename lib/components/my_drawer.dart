import 'package:books_log_migration/pages/change_password_page.dart';
import 'package:books_log_migration/pages/profile_page.dart';
import 'package:books_log_migration/pages/reading_list_page.dart';
import 'package:books_log_migration/pages/search_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CurrentPage { SEARCH, PROFILE, MY_BOOKS, READING_LIST }

class MyDrawer extends StatelessWidget {
  final CurrentPage currentPage;
  const MyDrawer({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthService>().getCurrentUser();
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user.displayName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(
                user.email!,
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .color!
                        .withOpacity(0.7)),
              ),
              currentAccountPicture: GestureDetector(
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(80),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(user.photoURL!),
                    onForegroundImageError: (exception, stackTrace) =>
                        Text(user.displayName![0]),
                  ),
                ),
                onTap: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => ProfilePage());
                  Navigator.pop(context);
                  if (currentPage != CurrentPage.PROFILE) {
                    Navigator.push(context, route);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person_rounded),
                    title: Text('Profile', style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => ProfilePage());
                      Navigator.pop(context);
                      if (currentPage != CurrentPage.PROFILE) {
                        Navigator.push(context, route);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book_rounded),
                    title: Text('My Books', style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    onTap: () {
                      Navigator.pop(context);
                      if (currentPage != CurrentPage.MY_BOOKS) {
                        Navigator.popUntil(
                            context, (route) => !Navigator.canPop(context));
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Search & Add', style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (context) => SearchPage());
                      Navigator.pop(context);
                      if (currentPage != CurrentPage.SEARCH) {
                        Navigator.push(context, route);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.watch_later_rounded),
                    title: Text('Reading List', style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => ReadingListPage());
                      Navigator.pop(context);
                      if (currentPage != CurrentPage.READING_LIST) {
                        Navigator.push(context, route);
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.settings_rounded),
                    title: Text('Settings', style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => ChangePasswordPage());
                      Navigator.pop(context);
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text('Log Out', style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    onTap: () async {
                      await context.read<AuthService>().signOut();
                      Navigator.popUntil(
                          context, (route) => !Navigator.canPop(context));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
