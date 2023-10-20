import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/pages/home/my_books_page.dart';
import 'package:books_log_migration/pages/home/profile_page.dart';
import 'package:books_log_migration/pages/home/reading_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _currentPage = 0;
  final List _pages = [
    const MyBooksPage(),
    const ReadingListPage(),
    const ProfilePage(),
  ];
  static const _iconColor = Color(0xffADADAD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        backgroundColor: AppColors.inputfieldBg,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.house,
              color: _iconColor,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.book,
              color: AppColors.primary2,
            ),
            label: 'My Books',
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.solidBookmark,
              color: _iconColor,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.solidBookmark,
              color: AppColors.primary2,
            ),
            label: 'Reading List',
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.solidUser,
              color: _iconColor,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.solidUser,
              color: AppColors.primary2,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
