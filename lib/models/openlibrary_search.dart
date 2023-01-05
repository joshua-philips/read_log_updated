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
      newDocs.add(Docs.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numFound'] = numFound;
    data['start'] = start;
    data['numFoundExact'] = numFoundExact;
    data['docs'] = docs.map((v) => v.toJson()).toList();
    data['num_found'] = numFound;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['text'] = text;
    data['type'] = type;
    data['seed'] = seed;
    data['title'] = title;
    data['title_suggest'] = titleSuggest;
    data['has_fulltext'] = hasFulltext;
    data['edition_count'] = editionCount;
    data['edition_key'] = editionKey;
    data['publish_date'] = publishDate;
    data['publish_year'] = publishYear;
    data['first_publish_year'] = firstPublishYear;
    data['lccn'] = lccn;
    data['publish_place'] = publishPlace;
    data['oclc'] = oclc;
    data['contributor'] = contributor;
    data['lcc'] = lcc;
    data['ddc'] = ddc;
    data['isbn'] = isbn;
    data['last_modified_i'] = lastModifiedI;
    data['ebook_count_i'] = ebookCountI;
    data['ia'] = ia;
    data['public_scan_b'] = publicScanB;
    data['ia_collection_s'] = iaCollectionS;
    data['lending_edition_s'] = lendingEditionS;
    data['lending_identifier_s'] = lendingIdentifierS;
    data['printdisabled_s'] = printdisabledS;
    data['cover_edition_key'] = coverEditionKey;
    data['cover_i'] = coverI;
    data['first_sentence'] = firstSentence;
    data['publisher'] = publisher;
    data['language'] = language;
    data['author_key'] = authorKey;
    data['author_name'] = authorName;
    data['author_alternative_name'] = authorAlternativeName;
    data['person'] = person;
    data['place'] = place;
    data['subject'] = subject;
    data['time'] = time;
    data['id_amazon'] = idAmazon;
    data['id_goodreads'] = idGoodreads;
    data['id_librarything'] = idLibrarything;
    data['ia_box_id'] = iaBoxId;
    data['publisher_facet'] = publisherFacet;
    data['person_key'] = personKey;
    data['time_facet'] = timeFacet;
    data['place_key'] = placeKey;
    data['person_facet'] = personFacet;
    data['subject_facet'] = subjectFacet;
    data['_version_'] = iVersion;
    data['place_facet'] = placeFacet;
    data['lcc_sort'] = lccSort;
    data['author_facet'] = authorFacet;
    data['subject_key'] = subjectKey;
    data['time_key'] = timeKey;
    data['ddc_sort'] = ddcSort;
    return data;
  }
}
