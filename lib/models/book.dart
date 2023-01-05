import 'package:books_log_migration/models/openlibrary_book.dart';

class Book {
  String title;
  List<String> author;
  int firstPublishYear;
  String coverImage;
  String summary;
  List<String> subject;
  List<String> place;
  List<String> time;
  List<String> person;
  List<String> publisher;
  List<int> publishYear;
  List<Links> links;
  String review;
  DateTime dateAdded;

  Book({
    required this.title,
    required this.author,
    required this.firstPublishYear,
    required this.coverImage,
    required this.summary,
    required this.subject,
    required this.place,
    required this.time,
    required this.person,
    required this.publisher,
    required this.publishYear,
    required this.links,
    required this.review,
    required this.dateAdded,
  });

  factory Book.noValues() {
    return Book(
      author: [],
      coverImage: '',
      firstPublishYear: 0,
      title: '',
      links: [],
      person: [],
      place: [],
      publishYear: [],
      publisher: [],
      review: '',
      subject: [],
      summary: '',
      time: [],
      dateAdded: DateTime.now(),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    List<Links> newLinks = [];
    json['links'] != null
        ? json['links'].forEach((v) {
            newLinks.add(Links.fromJson(v));
          })
        : newLinks = [];
    return Book(
      title: json['title'] ?? '',
      author: List<String>.from(json['author']),
      coverImage: json['coverImage'] ?? '',
      firstPublishYear: json['firstPublishYear'] ?? 0,
      review: json['review'] ?? '',
      publishYear: List<int>.from(json['publishYear']),
      time: List<String>.from(json['time']),
      summary: json['summary'] ?? '',
      person: List<String>.from(json['person']),
      place: List<String>.from(json['place']),
      publisher: List<String>.from(json['publisher']),
      subject: List<String>.from(json['subject']),
      links: newLinks,
      dateAdded: json['dateAdded'].toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['coverImage'] = coverImage;
    data['firstPublishYear'] = firstPublishYear;
    data['review'] = review;
    data['publishYear'] = publishYear;
    data['time'] = time;
    data['summary'] = summary;
    data['person'] = person;
    data['place'] = place;
    data['publisher'] = publisher;
    data['subject'] = subject;
    data['links'] = links.map((e) => e.toJson()).toList();
    data['dateAdded'] = dateAdded;

    return data;
  }

  void updateReview(String review) {
    this.review = review;
  }

  void setDateAdded(DateTime date) {
    dateAdded = date;
  }
}
