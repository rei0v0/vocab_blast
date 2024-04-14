import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/sentence.dart';
import 'package:vocab_blast/model/vocabulary.dart';

part 'book.freezed.dart';

@freezed
abstract class Book with _$Book {
  const factory Book({
    @Default([]) List<Vocab> vocabBook,
    @Default([]) List<Sentence> compBook,
    @Default([]) List<Quiz> quizBook,
  }) = _Book;
}