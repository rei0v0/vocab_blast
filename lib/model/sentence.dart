final String tableComp = 'CompBook';

class SentenceFields {
  static final String id = '_id';
  static final String textId = 'textId';
  static final String sentence = 'sentence';
  static final String translation = 'translation';
  static final String done = 'done';
}
class Sentence {
  final int? id;
  final String textId;
  final String sentence;
  final String translation;
  final int done;

  const Sentence({
    this.id,
    required this.textId,
    required this.sentence,
    required this.translation,
    required this.done

  });

  Sentence copy({
    int? id,
    String? textId,
    String? sentence,
    String? translation,
    int? done
  }) =>
      Sentence(
          id: id ?? this.id,
          textId:  textId ?? this.textId,
          sentence: sentence ?? this.sentence,
          translation: translation ?? this.translation,
          done: done ?? this.done
      );

  static Sentence fromJson(Map<String, Object?> json) => Sentence(
    id: json[SentenceFields.id] as int,
    textId : json[SentenceFields.textId] as String,
    sentence : json[SentenceFields.sentence] as String,
    translation : json[SentenceFields.translation] as String,
    done : json[SentenceFields.done] as int,
  );


  Map<String, Object?> toJson() => {
    SentenceFields.id: id,
    SentenceFields.textId: textId,
    SentenceFields.sentence: sentence,
    SentenceFields.translation: translation,
    SentenceFields.done: done,
  };
}

