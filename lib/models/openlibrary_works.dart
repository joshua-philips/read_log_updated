class OpenLibraryWorks {
  dynamic description;
  String title;

  /// Int list
  List<dynamic> covers;
  List<dynamic> subjectPlaces;
  List<dynamic> subjects;
  List<dynamic> subjectPeople;
  String key;
  List<Authors> authors;
  List<dynamic> subjectTimes;
  dynamic type;
  int latestRevision;
  int revision;
  Created created;
  Created lastModified;

  OpenLibraryWorks({
    required this.description,
    required this.title,
    required this.covers,
    required this.subjectPlaces,
    required this.subjects,
    required this.subjectPeople,
    required this.key,
    required this.authors,
    required this.subjectTimes,
    required this.type,
    required this.latestRevision,
    required this.revision,
    required this.created,
    required this.lastModified,
  });

  factory OpenLibraryWorks.noValues() {
    return OpenLibraryWorks(
      description: '',
      title: '',
      covers: [],
      subjectPlaces: [],
      subjects: [],
      subjectPeople: [],
      key: '',
      authors: [],
      subjectTimes: [],
      type: '',
      latestRevision: 0,
      revision: 0,
      created: Created(type: '', value: ''),
      lastModified: Created(type: '', value: ''),
    );
  }

  factory OpenLibraryWorks.fromJson(Map<String, dynamic> json) {
    List<Authors> newAuthors = [];
    json['authors'] != null
        ? json['authors'].forEach((v) {
            newAuthors.add(new Authors.fromJson(v));
          })
        : newAuthors = [];
    return OpenLibraryWorks(
      description: json['description'].length < 4
          ? json['description']['value'] ?? ''
          : json['description'] ?? '',
      title: json['title'] ?? '',
      covers: json['covers'] ?? [],
      subjectPlaces: json['subject_places'] ?? [],
      subjects: json['subjects'] ?? [],
      subjectPeople: json['subject_people'] ?? [],
      key: json['key'],
      authors: newAuthors,
      subjectTimes: json['subject_times'] ?? [],
      type: json['type'] ?? '',
      latestRevision: json['latest_revision'] ?? 0,
      revision: json['revision'] ?? 0,
      created: Created.fromJson(json['created']),
      lastModified: Created.fromJson(json['last_modified']),
    );
  }
}

class Authors {
  Author author;
  Author type;

  Authors({required this.author, required this.type});

  factory Authors.fromJson(Map<String, dynamic> json) {
    return Authors(
      author: Author.fromJson(json['author'] ?? Author(key: '')),
      type: Author.fromJson(json['type'] ?? Author(key: '')),
    );
  }
}

class Author {
  String key;

  Author({required this.key});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      key: json['key'] ?? '',
    );
  }
}

class Created {
  String type;
  String value;

  Created({required this.type, required this.value});

  factory Created.fromJson(Map<String, dynamic> json) {
    return Created(
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }
}
