import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchContaner extends StatelessWidget {
  const SearchContaner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Route route =
            MaterialPageRoute(builder: (context) => const SearchPage());
        Navigator.push(context, route);
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: AppColors.inputfieldBg,
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 18,
              color: AppColors.bodyText,
            ),
            gapW8,
            const Text('Type to find books..'),
          ],
        ),
      ),
    );
  }
}
