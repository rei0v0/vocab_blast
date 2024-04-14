class TagFields {
  static final String id = '_id';
  static final String name = 'name';
}
final String tableTag = 'tag';

class Tag {
  final int? id;
  final String name;

  const Tag({
    this.id,
    required this.name,
  });

  Tag copy({
    int? id,
    String? name,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static Tag fromJson(Map<String, Object?> json) => Tag(
    id: json[TagFields.id] as int,
    name : json[TagFields.name] as String,
  );


  Map<String, Object?> toJson() => {
    TagFields.id: id,
    TagFields.name: name,
  };
}

