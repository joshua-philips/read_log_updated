import 'package:books_log_migration/components/dialogs_and_snackbar.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/models/openlibrary_book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> horizontalDetailList(List detailList) {
  List<Widget> widgetList = [];
  for (int count = 0; count < detailList.length; count++) {
    widgetList.add(
      Padding(
        padding: const EdgeInsets.only(right: defaultPadding / 2),
        child: Chip(label: Text(detailList[count].toString())),
      ),
    );
  }
  return widgetList;
}

List<Widget> horizontalDetailListSorted(List detailList) {
  detailList.sort();
  List<Widget> widgetList = [];
  for (int count = 0; count < detailList.length; count++) {
    widgetList.add(
      Padding(
        padding: const EdgeInsets.only(right: defaultPadding / 2),
        child: Chip(label: Text(detailList[count].toString())),
      ),
    );
  }
  return widgetList;
}

List<Widget> listOfLinks(List<Links> list, BuildContext context) {
  List<Widget> widgetList = [];
  for (int count = 0; count < list.length; count++) {
    widgetList.add(
      Padding(
        padding: const EdgeInsets.only(right: defaultPadding / 2),
        child: ActionChip(
          label: Text(
            list[count].title.toString(),
          ),
          backgroundColor: AppColors.inputfieldBg,
          side: BorderSide(color: AppColors.primary2),
          labelStyle: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: AppColors.primary2),
          onPressed: () async {
            // TODO: Consider using webview instead
            if (await canLaunch(list[count].url)) {
              await launch(list[count].url);
            } else {
              showMessageSnackBar(context, "Could not open web view");
            }
          },
        ),
      ),
    );
  }
  return widgetList;
}

List<Widget> writersRow(List<dynamic> authorName) {
  List<Widget> writers = [];

  if (authorName.isNotEmpty) {
    for (int count = 0; count < authorName.length; count++) {
      writers.add(
        Text(
          authorName[count],
        ),
      );
      if (count != authorName.length - 1) {
        writers.add(
          const Text(
            '/',
          ),
        );
      }
    }
  } else {
    writers.add(
      const Text(
        'Unknown',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  return writers;
}
