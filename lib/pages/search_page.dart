import 'dart:convert';
import 'dart:developer';

import 'package:books_log_migration/components/horizontal_list.dart';
import 'package:books_log_migration/components/section_tile.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/models/openlibrary_search.dart';
import 'package:books_log_migration/pages/fetch_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

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
      log('Error: ' + e.toString());
      setState(() {
        searchOngoing = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.text,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              autofocus: true,
              onSubmitted: (text) {
                if (searchController.text.isNotEmpty) {
                  openLibrarySearch(searchController.text);
                }
              },
              decoration: InputDecoration(
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
            SectionListTile(
              title: "Search results",
              press: () {},
              trailingText: "",
            ),
            buildSearchBody(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBody() {
    if (searchOngoing && searchCompleted == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (searchOngoing == false && searchCompleted) {
      return results.numFound <= 0
          ? const Center(
              child: Text('No Results'),
            )
          : Scrollbar(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: results.docs.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 0,
                  child: InkWell(
                    onTap: () async {
                      Route route = MaterialPageRoute(
                        builder: (_) => FetchDetailsPage(
                          openLibrarySearchDoc: results.docs[index],
                        ),
                      );
                      Navigator.push(context, route);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                results.docs[index].title,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              SizedBox(
                                height: 20,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: writersRow(
                                      results.docs[index].authorName),
                                ),
                              ),
                              Text(results.docs[index].firstPublishYear
                                  .toString()),
                              Text(results.docs[index].publisher.first)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
    } else if (error) {
      return const Center(
        child: Text('Server error'),
      );
    } else {
      return Container();
    }
  }
}
