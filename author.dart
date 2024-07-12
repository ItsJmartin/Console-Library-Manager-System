class Author{
  String name;
  String since;
  List<String> bookWritten;

  Author(this.name, this.since, this.bookWritten);
  Map<String, dynamic>toJson() => {
    'name': name,
    'since' : since,
    'bookWritten' : bookWritten,
  };

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    json['name'],
    json['since'],
    List<String>.from(json['booksWritten']),
  );
}