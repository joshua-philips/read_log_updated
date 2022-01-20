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
            newLinks.add(new Links.fromJson(v));
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
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['coverImage'] = this.coverImage;
    data['firstPublishYear'] = this.firstPublishYear;
    data['review'] = this.review;
    data['publishYear'] = this.publishYear;
    data['time'] = this.time;
    data['summary'] = this.summary;
    data['person'] = this.person;
    data['place'] = this.place;
    data['publisher'] = this.publisher;
    data['subject'] = this.subject;
    data['links'] = this.links.map((e) => e.toJson()).toList();
    data['dateAdded'] = this.dateAdded;

    return data;
  }

  void updateReview(String review) {
    this.review = review;
  }

  void setDateAdded(DateTime date) {
    this.dateAdded = date;
  }
}
