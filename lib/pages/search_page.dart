import 'dart:convert';

import 'package:books_log_migration/components/horizontal_list.dart';
import 'package:books_log_migration/components/my_drawer.dart';
import 'package:books_log_migration/models/openlibrary_search.dart';
import 'package:books_log_migration/pages/fetch_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late OpenLibrarySearch results;
  bool searchOngoing = false;
  bool searchCompleted = false;
  bool error = false;

  String searchUrl = 'http://openlibrary.org/search.json?q=';

  Future openLibrarySearch(String title) async {
    setState(() {
      searchOngoing = true;
      searchCompleted = false;
      error = false;
    });
    try {
      http.Response response = await http.get(Uri.parse(searchUrl + title));
      OpenLibrarySearch searchResults =
          OpenLibrarySearch.fromJson(json.decode(response.body));
      setState(() {
        results = searchResults;
        searchOngoing = false;
        searchCompleted = true;
      });
    } catch (e) {
      print('Error: ' + e.toString());
      setState(() {
        searchOngoing = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(currentPage: CurrentPage.SEARCH),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          padding: EdgeInsets.only(left: 8, right: 5),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.2),
          ),
          child: TextField(
            controller: searchController,
            autofocus: true,
            onSubmitted: (text) {
              if (searchController.text.isNotEmpty) {
                openLibrarySearch(searchController.text);
              }
            },
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
              ),
              hintText: 'Search title, author',
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ),
      body: buildSearchBody(),
    );
  }

  Widget buildSearchBody() {
    if (searchOngoing && searchCompleted == false) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    } else if (searchOngoing == false && searchCompleted) {
      return results.numFound <= 0
          ? Center(
              child: Text('No Results'),
            )
          : Scrollbar(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: results.docs.length,
                itemBuilder: (context, index) => GestureDetector(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      title: Text(
                        results.docs[index].title,
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          height: 25,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children:
                                writersRow(results.docs[index].authorName),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Route route = MaterialPageRoute(
                      builder: (_) => FetchDetailsPage(
                        openLibrarySearchDoc: results.docs[index],
                      ),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ),
            );
    } else if (error) {
      return Center(
        child: Text('Server error'),
      );
    } else {
      return Container();
    }
  }
}
