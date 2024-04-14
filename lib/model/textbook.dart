final String tableTextbook = 'textbook';

class TextbookFields {
  static final String id = '_id';
  static final String checkId = 'checkId';
  static final String name = 'name';
  static final String type = 'type';
  static final String date = 'date';
}
class TextBook {
  final int? id;
  final String checkId;
  final String name;
  final String type;
  final String date;
  final List<String> tags;

  const TextBook({
    this.id,
    required this.checkId,
    required this.name,
    required this.type,
    required this.date,
    required this.tags,
  });

  TextBook copy({
    int? id,
    String? checkId,
    String? name,
    String? type,
    String? date,
    List<String>? tags,
  }) =>
      TextBook(
          id: id ?? this.id,
          checkId: checkId ?? this.checkId,
          name: name ?? this.name,
          type: type ?? this.type,
          date: date ?? this.date,
          tags: tags ?? this.tags,
      );

  static TextBook fromJson(Map<String, Object?> json) => TextBook(
      id: json[TextbookFields.id] as int,
      checkId: json[TextbookFields.checkId] as String,
      name : json[TextbookFields.name] as String,
      type : json[TextbookFields.type] as String,
      date:  json[TextbookFields.date] as String,
      tags: [],
  );


  Map<String, Object?> toJson() => {
    TextbookFields.id: id,
    TextbookFields.checkId: checkId,
    TextbookFields.name: name,
    TextbookFields.type: type,
    TextbookFields.date: date,
  };
}

