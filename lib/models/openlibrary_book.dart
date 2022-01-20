/// Always use the LCCN ("LCCN:...") to enter the initial map first before using the
/// model
class OpenLibraryBook {
  String url;
  String key;
  String title;
  List<Authors> authors;
  int numberOfPages;
  String pagination;
  String byStatement;
  Identifiers identifiers;
  Classifications classifications;
  List<Publishers> publishers;
  List<PublishPlaces> publishPlaces;
  String publishDate;
  List<Subjects> subjects;
  List<SubjectPlaces> subjectPlaces;
  List<SubjectPeople> subjectPeople;
  List<SubjectTimes> subjectTimes;
  List<Excerpts> excerpts;
  String notes;
  List<Links> links;
  List<Ebooks> ebooks;
  Cover cover;

  OpenLibraryBook({
    required this.url,
    required this.key,
    required this.title,
    required this.authors,
    required this.numberOfPages,
    required this.pagination,
    required this.byStatement,
    required this.identifiers,
    required this.classifications,
    required this.publishers,
    required this.publishPlaces,
    required this.publishDate,
    required this.subjects,
    required this.subjectPlaces,
    required this.subjectPeople,
    required this.subjectTimes,
    required this.excerpts,
    required this.notes,
    required this.links,
    required this.ebooks,
    required this.cover,
  });
  factory OpenLibraryBook.noValues() {
    return OpenLibraryBook(
      authors: [],
      byStatement: '',
      classifications: Classifications(
        lcClassifications: [],
        deweyDecimalClass: [],
      ),
      cover: Cover(small: '', medium: '', large: ''),
      ebooks: [],
      excerpts: [],
      identifiers: Identifiers(
          goodreads: [],
          librarything: [],
          isbn10: [],
          lccn: [],
          openlibrary: []),
      key: '',
      links: [],
      notes: '',
      numberOfPages: 0,
      pagination: '',
      publishDate: '',
      publishPlaces: [],
      publishers: [],
      subjectPeople: [],
      subjectPlaces: [],
      subjectTimes: [],
      subjects: [],
      title: '',
      url: '',
    );
  }

  factory OpenLibraryBook.fromJson(Map<String, dynamic> json) {
    List<Authors> newAuthors = [];
    json['authors'] != null
        ? json['authors'].forEach((v) {
            newAuthors.add(new Authors.fromJson(v));
          })
        : newAuthors = [];

    List<Publishers> newPublishers = [];
    json['publishers'] != null
        ? json['publishers'].forEach((v) {
            newPublishers.add(new Publishers.fromJson(v));
          })
        : newPublishers = [];

    List<PublishPlaces> newPublishPlaces = [];
    json['publish_places'] != null
        ? json['publish_places'].forEach((v) {
            newPublishPlaces.add(new PublishPlaces.fromJson(v));
          })
        : newPublishPlaces = [];

    List<Subjects> newSubjects = [];
    json['subjects'] != null
        ? json['subjects'].forEach((v) {
            newSubjects.add(new Subjects.fromJson(v));
          })
        : newSubjects = [];

    List<SubjectPlaces> newSubjectPlaces = [];
    json['subject_places'] != null
        ? json['subject_places'].forEach((v) {
            newSubjectPlaces.add(new SubjectPlaces.fromJson(v));
          })
        : newSubjectPlaces = [];

    List<SubjectPeople> newSubjectPeople = [];
    json['subject_people'] != null
        ? json['subject_people'].forEach((v) {
            newSubjectPeople.add(new SubjectPeople.fromJson(v));
          })
        : newSubjectPeople = [];

    List<SubjectTimes> newSubjectTimes = [];
    json['subject_times'] != null
        ? json['subject_times'].forEach((v) {
            newSubjectTimes.add(new SubjectTimes.fromJson(v));
          })
        : newSubjectTimes = [];

    List<Ebooks> newEbooks = [];
    json['ebooks'] != null
        ? json['ebooks'].forEach((v) {
            newEbooks.add(new Ebooks.fromJson(v));
          })
        : newEbooks = [];

    List<Excerpts> newExcerpts = [];
    json['excerpts'] != null
        ? json['excerpts'].forEach((v) {
            newExcerpts.add(new Excerpts.fromJson(v));
          })
        : newExcerpts = [];

    List<Links> newLinks = [];
    json['links'] != null
        ? json['links'].forEach((v) {
            newLinks.add(new Links.fromJson(v));
          })
        : newLinks = [];

    return OpenLibraryBook(
      url: json['url'] ?? '',
      key: json['key'] ?? '',
      title: json['title'] ?? '',
      authors: newAuthors,
      numberOfPages: json['number_of_pages'] ?? 0,
      pagination: json['pagination'] ?? '',
      byStatement: json['by_statement'] ?? '',
      identifiers: Identifiers.fromJson(json['identifiers']),
      classifications: Classifications.fromJson(json['classifications']),
      publishers: newPublishers,
      publishPlaces: newPublishPlaces,
      publishDate: json['publish_date'] ?? '',
      subjects: newSubjects,
      subjectPlaces: newSubjectPlaces,
      subjectPeople: newSubjectPeople,
      subjectTimes: newSubjectTimes,
      excerpts: newExcerpts,
      notes: json['notes'] ?? '',
      links: newLinks,
      ebooks: newEbooks,
      cover: Cover.fromJson(json['cover']),
    );
  }
}

class Authors {
  String url;
  String name;

  Authors({required this.url, required this.name});

  factory Authors.fromJson(Map<String, dynamic> json) {
    return Authors(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Subjects {
  String url;
  String name;

  Subjects({required this.url, required this.name});

  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SubjectPlaces {
  String url;
  String name;

  SubjectPlaces({required this.url, required this.name});

  factory SubjectPlaces.fromJson(Map<String, dynamic> json) {
    return SubjectPlaces(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SubjectPeople {
  String url;
  String name;

  SubjectPeople({required this.url, required this.name});

  factory SubjectPeople.fromJson(Map<String, dynamic> json) {
    return SubjectPeople(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SubjectTimes {
  String url;
  String name;

  SubjectTimes({required this.url, required this.name});

  factory SubjectTimes.fromJson(Map<String, dynamic> json) {
    return SubjectTimes(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Excerpts {
  String text;
  String comment;

  Excerpts({required this.text, required this.comment});

  factory Excerpts.fromJson(Map<String, dynamic> json) {
    return Excerpts(
      text: json['text'] ?? '',
      comment: json['comment'] ?? '',
    );
  }
}

class Links {
  String title;
  String url;

  Links({required this.title, required this.url});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class Identifiers {
  List<dynamic> goodreads;
  List<dynamic> librarything;
  List<dynamic> isbn10;
  List<dynamic> lccn;
  List<dynamic> openlibrary;

  Identifiers(
      {required this.goodreads,
      required this.librarything,
      required this.isbn10,
      required this.lccn,
      required this.openlibrary});

  factory Identifiers.fromJson(Map<String, dynamic> json) {
    return Identifiers(
      goodreads: json['goodreads'] ?? [],
      librarything: json['librarything'] ?? [],
      isbn10: json['isbn_10'] ?? [],
      lccn: json['lccn'] ?? [],
      openlibrary: json['openlibrary'] ?? [],
    );
  }
}

class Classifications {
  List<dynamic> lcClassifications;
  List<dynamic> deweyDecimalClass;

  Classifications({
    required this.lcClassifications,
    required this.deweyDecimalClass,
  });

  factory Classifications.fromJson(Map<String, dynamic> json) {
    return Classifications(
      lcClassifications: json['lc_classifications'] ?? [],
      deweyDecimalClass: json['dewey_decimal_class'] ?? [],
    );
  }
}

class Publishers {
  String name;

  Publishers({required this.name});

  factory Publishers.fromJson(Map<String, dynamic> json) {
    return Publishers(name: json['name'] ?? '');
  }
}

class PublishPlaces {
  String name;

  PublishPlaces({required this.name});

  factory PublishPlaces.fromJson(Map<String, dynamic> json) {
    return PublishPlaces(name: json['name'] ?? '');
  }
}

class Ebooks {
  String previewUrl;
  String availability;
  Formats formats;
  String borrowUrl;
  bool checkedout;

  Ebooks(
      {required this.previewUrl,
      required this.availability,
      required this.formats,
      required this.borrowUrl,
      required this.checkedout});

  factory Ebooks.fromJson(Map<String, dynamic> json) {
    return Ebooks(
      previewUrl: json['preview_url'] ?? '',
      availability: json['availability'] ?? '',
      formats: Formats.fromJson(json['formats']),
      borrowUrl: json['borrow_url'] ?? '',
      checkedout: json['checkedout'] ?? false,
    );
  }
}

class Formats {
  Map<dynamic, dynamic> formats;

  Formats({required this.formats});

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      formats: json['formats'] ?? {},
    );
  }
}

class Cover {
  String small;
  String medium;
  String large;

  Cover({required this.small, required this.medium, required this.large});

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      small: json['small'] ?? '',
      medium: json['medium'] ?? '',
      large: json['large'] ?? '',
    );
  }
}
