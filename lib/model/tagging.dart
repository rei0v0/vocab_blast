class TaggingFields {
  static final String id = '_id';
  static final String textbookId = 'textbook_id';
  static final String tagId = 'tag_id';
}
final String tableTagging = 'tagging';

class Tagging {
  final int? id;
  final int textbookId;
  final int tagId;

  const Tagging({
    this.id,
    required this.textbookId,
    required this.tagId,
  });

  Tagging copy({
    int? id,
    int? textbookId,
    int? tagId,
  }) =>
      Tagging(
        id: id ?? this.id,
        textbookId: textbookId ?? this.textbookId,
        tagId: tagId ?? this.tagId,
      );

  static Tagging fromJson(Map<String, Object?> json) => Tagging(
    id: json[TaggingFields.id] as int,
    textbookId : json[TaggingFields.textbookId] as int,
    tagId : json[TaggingFields.tagId] as int,
  );


  Map<String, Object?> toJson() => {
    TaggingFields.id: id,
    TaggingFields.textbookId: textbookId,
    TaggingFields.tagId: tagId,
  };
}

