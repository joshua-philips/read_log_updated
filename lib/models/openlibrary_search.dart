class OpenLibrarySearch {
  int numFound;
  int start;
  bool numFoundExact;
  List<Docs> docs;
  int numFound2;

  OpenLibrarySearch(
      {required this.numFound,
      required this.start,
      required this.numFoundExact,
      required this.docs,
      required this.numFound2});

  factory OpenLibrarySearch.fromJson(Map<String, dynamic> json) {
    List<Docs> newDocs = [];
    json['docs'].forEach((v) {
      newDocs.add(new Docs.fromJson(v));
    });
    return OpenLibrarySearch(
      numFound: json['numFound'] ?? 0,
      start: json['start'] ?? 0,
      numFoundExact: json['numFoundExact'] ?? false,
      docs: newDocs,
      numFound2: json['num_found'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numFound'] = this.numFound;
    data['start'] = this.start;
    data['numFoundExact'] = this.numFoundExact;
    data['docs'] = this.docs.map((v) => v.toJson()).toList();
    data['num_found'] = this.numFound;
    return data;
  }
}

class Docs {
  String key;
  List<dynamic> text;
  String type;
  List<dynamic> seed;
  String title;
  String titleSuggest;
  bool hasFulltext;
  int editionCount;
  List<dynamic> editionKey;
  List<dynamic> publishDate;

  /// List of int
  List<dynamic> publishYear;
  int firstPublishYear;
  List<dynamic> lccn;
  List<dynamic> publishPlace;
  List<dynamic> oclc;
  List<dynamic> contributor;
  List<dynamic> lcc;
  List<dynamic> ddc;
  List<dynamic> isbn;
  int lastModifiedI;
  int ebookCountI;
  List<dynamic> ia;
  bool publicScanB;
  String iaCollectionS;
  String lendingEditionS;
  String lendingIdentifierS;
  String printdisabledS;
  String coverEditionKey;
  int coverI;
  List<dynamic> firstSentence;
  List<dynamic> publisher;
  List<dynamic> language;
  List<dynamic> authorKey;
  List<dynamic> authorName;
  List<dynamic> authorAlternativeName;
  List<dynamic> person;
  List<dynamic> place;
  List<dynamic> subject;
  List<dynamic> time;
  List<dynamic> idAmazon;
  List<dynamic> idGoodreads;
  List<dynamic> idLibrarything;
  List<dynamic> iaBoxId;
  List<dynamic> publisherFacet;
  List<dynamic> personKey;
  List<dynamic> timeFacet;
  List<dynamic> placeKey;
  List<dynamic> personFacet;
  List<dynamic> subjectFacet;
  int iVersion;
  List<dynamic> placeFacet;
  String lccSort;
  List<dynamic> authorFacet;
  List<dynamic> subjectKey;
  List<dynamic> timeKey;
  String ddcSort;

  Docs(
      {required this.key,
      required this.text,
      required this.type,
      required this.seed,
      required this.title,
      required this.titleSuggest,
      required this.hasFulltext,
      required this.editionCount,
      required this.editionKey,
      required this.publishDate,
      required this.publishYear,
      required this.firstPublishYear,
      required this.lccn,
      required this.publishPlace,
      required this.oclc,
      required this.contributor,
      required this.lcc,
      required this.ddc,
      required this.isbn,
      required this.lastModifiedI,
      required this.ebookCountI,
      required this.ia,
      required this.publicScanB,
      required this.iaCollectionS,
      required this.lendingEditionS,
      required this.lendingIdentifierS,
      required this.printdisabledS,
      required this.coverEditionKey,
      required this.coverI,
      required this.firstSentence,
      required this.publisher,
      required this.language,
      required this.authorKey,
      required this.authorName,
      required this.authorAlternativeName,
      required this.person,
      required this.place,
      required this.subject,
      required this.time,
      required this.idAmazon,
      required this.idGoodreads,
      required this.idLibrarything,
      required this.iaBoxId,
      required this.publisherFacet,
      required this.personKey,
      required this.timeFacet,
      required this.placeKey,
      required this.personFacet,
      required this.subjectFacet,
      required this.iVersion,
      required this.placeFacet,
      required this.lccSort,
      required this.authorFacet,
      required this.subjectKey,
      required this.timeKey,
      required this.ddcSort});

  factory Docs.fromJson(Map<String, dynamic> json) {
    return Docs(
      key: json['key'] ?? '',
      text: json['text'] ?? [],
      type: json['type'] ?? '',
      seed: json['seed'] ?? [],
      title: json['title'] ?? '',
      titleSuggest: json['title_suggest'] ?? '',
      hasFulltext: json['has_fulltext'] ?? false,
      editionCount: json['edition_count'] ?? 0,
      editionKey: json['edition_key'] ?? [],
      publishDate: json['publish_date'] ?? [],
      publishYear: json['publish_year'] ?? [],
      firstPublishYear: json['first_publish_year'] ?? 0,
      lccn: json['lccn'] ?? [],
      publishPlace: json['publish_place'] ?? [],
      oclc: json['oclc'] ?? [],
      contributor: json['contributor'] ?? [],
      lcc: json['lcc'] ?? [],
      ddc: json['ddc'] ?? [],
      isbn: json['isbn'] ?? [],
      lastModifiedI: json['last_modified_i'] ?? 0,
      ebookCountI: json['ebook_count_i'] ?? 0,
      ia: json['ia'] ?? [],
      publicScanB: json['public_scan_b'] ?? false,
      iaCollectionS: json['ia_collection_s'] ?? '',
      lendingEditionS: json['lending_edition_s'] ?? '',
      lendingIdentifierS: json['lending_identifier_s'] ?? '',
      printdisabledS: json['printdisabled_s'] ?? '',
      coverEditionKey: json['cover_edition_key'] ?? '',
      coverI: json['cover_i'] ?? 0,
      firstSentence: json['first_sentence'] ?? [],
      publisher: json['publisher'] ?? [],
      language: json['language'] ?? [],
      authorKey: json['author_key'] ?? [],
      authorName: json['author_name'] ?? [],
      authorAlternativeName: json['author_alternative_name'] ?? [],
      person: json['person'] ?? [],
      place: json['place'] ?? [],
      subject: json['subject'] ?? [],
      time: json['time'] ?? [],
      idAmazon: json['id_amazon'] ?? [],
      idGoodreads: json['id_goodreads'] ?? [],
      idLibrarything: json['id_librarything'] ?? [],
      iaBoxId: json['ia_box_id'] ?? [],
      publisherFacet: json['publisher_facet'] ?? [],
      personKey: json['person_key'] ?? [],
      timeFacet: json['time_facet'] ?? [],
      placeKey: json['place_key'] ?? [],
      personFacet: json['person_facet'] ?? [],
      subjectFacet: json['subject_facet'] ?? [],
      iVersion: json['_version_'] ?? 0,
      placeFacet: json['place_facet'] ?? [],
      lccSort: json['lcc_sort'] ?? '',
      authorFacet: json['author_facet'] ?? [],
      subjectKey: json['subject_key'] ?? [],
      timeKey: json['time_key'] ?? [],
      ddcSort: json['ddc_sort'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['text'] = this.text;
    data['type'] = this.type;
    data['seed'] = this.seed;
    data['title'] = this.title;
    data['title_suggest'] = this.titleSuggest;
    data['has_fulltext'] = this.hasFulltext;
    data['edition_count'] = this.editionCount;
    data['edition_key'] = this.editionKey;
    data['publish_date'] = this.publishDate;
    data['publish_year'] = this.publishYear;
    data['first_publish_year'] = this.firstPublishYear;
    data['lccn'] = this.lccn;
    data['publish_place'] = this.publishPlace;
    data['oclc'] = this.oclc;
    data['contributor'] = this.contributor;
    data['lcc'] = this.lcc;
    data['ddc'] = this.ddc;
    data['isbn'] = this.isbn;
    data['last_modified_i'] = this.lastModifiedI;
    data['ebook_count_i'] = this.ebookCountI;
    data['ia'] = this.ia;
    data['public_scan_b'] = this.publicScanB;
    data['ia_collection_s'] = this.iaCollectionS;
    data['lending_edition_s'] = this.lendingEditionS;
    data['lending_identifier_s'] = this.lendingIdentifierS;
    data['printdisabled_s'] = this.printdisabledS;
    data['cover_edition_key'] = this.coverEditionKey;
    data['cover_i'] = this.coverI;
    data['first_sentence'] = this.firstSentence;
    data['publisher'] = this.publisher;
    data['language'] = this.language;
    data['author_key'] = this.authorKey;
    data['author_name'] = this.authorName;
    data['author_alternative_name'] = this.authorAlternativeName;
    data['person'] = this.person;
    data['place'] = this.place;
    data['subject'] = this.subject;
    data['time'] = this.time;
    data['id_amazon'] = this.idAmazon;
    data['id_goodreads'] = this.idGoodreads;
    data['id_librarything'] = this.idLibrarything;
    data['ia_box_id'] = this.iaBoxId;
    data['publisher_facet'] = this.publisherFacet;
    data['person_key'] = this.personKey;
    data['time_facet'] = this.timeFacet;
    data['place_key'] = this.placeKey;
    data['person_facet'] = this.personFacet;
    data['subject_facet'] = this.subjectFacet;
    data['_version_'] = this.iVersion;
    data['place_facet'] = this.placeFacet;
    data['lcc_sort'] = this.lccSort;
    data['author_facet'] = this.authorFacet;
    data['subject_key'] = this.subjectKey;
    data['time_key'] = this.timeKey;
    data['ddc_sort'] = this.ddcSort;
    return data;
  }
}
