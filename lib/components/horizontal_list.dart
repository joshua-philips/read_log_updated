import 'dart:developer';

import 'package:books_log_migration/models/openlibrary_book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> horizontalDetailList(List detailList) {
  List<Widget> widgetList = [];
  for (int count = 0; count < detailList.length; count++) {
    widgetList.add(
      Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          detailList[count].toString(),
        ),
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
      Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          detailList[count].toString(),
        ),
      ),
    );
  }
  return widgetList;
}

List<Widget> listOfLinks(List<Links> list, BuildContext context) {
  List<Widget> widgetList = [];
  for (int count = 0; count < list.length; count++) {
    widgetList.add(
      InkWell(
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: const Color(0xff07446C),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            list[count].title.toString(),
          ),
        ),
        onTap: () async {
          // TODO: Consider using webview instead
          if (await canLaunch(list[count].url)) {
            await launch(list[count].url);
          } else {
            log('Could not launch');
          }
        },
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
