final String tableVocab = 'VocabBook';

class VocabFields {
  static final String id = '_id';
  static final String textId = 'textId';
  static final String word = 'name';
  static final String meaning = 'meaning';
  static final String sentence = 'sentence';
  static final String translation = 'translation';
  static final String done = 'done';
}
class Vocab {
  final int? id;
  final String textId;
  final String word;
  final String meaning;
  final String sentence;
  final String translation;
  final int done;

  const Vocab({
    this.id,
    required this.textId,
    required this.word,
    required this.meaning,
    required this.sentence,
    required this.translation,
    required this.done

  });

  Vocab copy({
    int? id,
    String? textId,
    String? word,
    String? meaning,
    String? sentence,
    String? translation,
    int? done
  }) =>
      Vocab(
          id: id ?? this.id,
          textId:  textId ?? this.textId,
          word: word ?? this.word,
          meaning: meaning ?? this.meaning,
          sentence: sentence ?? this.sentence,
          translation: translation ?? this.translation,
          done: done ?? this.done
      );

  static Vocab fromJson(Map<String, Object?> json) => Vocab(
      id: json[VocabFields.id] as int,
      word : json[VocabFields.word] as String,
      textId : json[VocabFields.textId] as String,
      meaning : json[VocabFields.meaning] as String,
      sentence : json[VocabFields.sentence] as String,
      translation : json[VocabFields.translation] as String,
      done : json[VocabFields.done] as int,
  );


  Map<String, Object?> toJson() => {
    VocabFields.id: id,
    VocabFields.textId: textId,
    VocabFields.word: word,
    VocabFields.meaning: meaning,
    VocabFields.sentence: sentence,
    VocabFields.translation: translation,
    VocabFields.done: done,
  };
}

