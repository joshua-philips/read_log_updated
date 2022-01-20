import 'package:books_log_migration/models/openlibrary_book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> horizontalDetailList(List detailList) {
  List<Widget> widgetList = [];
  for (int count = 0; count < detailList.length; count++) {
    widgetList.add(
      Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 5),
        margin: EdgeInsets.only(right: 10),
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
        padding: EdgeInsets.only(left: 8, right: 8, top: 5),
        margin: EdgeInsets.only(right: 10),
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
          padding: EdgeInsets.only(left: 8, right: 8, top: 5),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Color(0xff07446C),
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
            print('Could not launch');
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
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      );
      if (count != authorName.length - 1) {
        writers.add(
          Text(
            '/',
            style: TextStyle(
              fontSize: 19,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        );
      }
    }
  } else {
    writers.add(
      Text(
        'Unknown',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  return writers;
}
