final String tableQuiz = 'QuizBook';

class QuizFields {
  static final String id = '_id';
  static final String textId = 'textId';
  static final String question = 'question';
  static final String choice0 = 'choice0';
  static final String choice1 = 'choice1';
  static final String choice2 = 'choice2';
  static final String choice3 = 'choice3';
  static final String answer = 'answer';
  static final String sentence = 'sentence';
  static final String translation = 'translation';
  static final String explanation = 'explanation';
  static final String done = 'done';
}
class Quiz {
  final int? id;
  final String textId;
  final String question;
  final String choice0;
  final String choice1;
  final String choice2;
  final String choice3;
  final int answer;
  final String sentence;
  final String translation;
  final String explanation;
  final int done;

  const Quiz({
    this.id,
    required this.textId,
    required this.question,
    required this.choice0,
    required this.choice1,
    required this.choice2,
    required this.choice3,
    required this.answer,
    required this.sentence,
    required this.translation,
    required this.explanation,
    required this.done

  });

  Quiz copy({
    int? id,
    String? textId,
    String? question,
    String? choice0,
    String? choice1,
    String? choice2,
    String? choice3,
    int? answer,
    String? sentence,
    String? translation,
    String? explanation,
    int? done
  }) =>
      Quiz(
          id: id ?? this.id,
          textId:  textId ?? this.textId,
          question: question ?? this.question,
          choice0: choice0 ?? this.choice0,
          choice1: choice1 ?? this.choice1,
          choice2: choice2 ?? this.choice2,
          choice3: choice3 ?? this.choice3,
          answer: answer ?? this.answer,
          sentence: sentence ?? this.sentence,
          translation: translation ?? this.translation,
          explanation: explanation ?? this.explanation,
          done: done ?? this.done
      );

  static Quiz fromJson(Map<String, Object?> json) => Quiz(
    id: json[QuizFields.id] as int,
    textId : json[QuizFields.textId] as String,
    question : json[QuizFields.question] as String,
    choice0 : json[QuizFields.choice0] as String,
    choice1 : json[QuizFields.choice1] as String,
    choice2 : json[QuizFields.choice2] as String,
    choice3 : json[QuizFields.choice3] as String,
    answer : json[QuizFields.answer] as int,
    sentence : json[QuizFields.sentence] as String,
    translation : json[QuizFields.translation] as String,
    explanation : json[QuizFields.explanation] as String,
    done : json[QuizFields.done] as int,
  );


  Map<String, Object?> toJson() => {
    QuizFields.id: id,
    QuizFields.textId: textId,
    QuizFields.question: question,
    QuizFields.choice0: choice0,
    QuizFields.choice1: choice1,
    QuizFields.choice2: choice2,
    QuizFields.choice3: choice3,
    QuizFields.answer: answer,
    QuizFields.sentence: sentence,
    QuizFields.translation: translation,
    QuizFields.explanation: explanation,
    QuizFields.done: done,
  };
}

