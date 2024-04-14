import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vocab_blast/model/textbook.dart';

part 'my_library.freezed.dart';

@freezed
abstract class MyLibrary with _$MyLibrary {
  const factory MyLibrary({
    @Default(0) int index,
    @Default([]) List<TextBook> vocabBooks,
    @Default([]) List<TextBook> compBooks,
    @Default([]) List<TextBook> quizBooks,
    @Default([]) List<String> vocabTags,
    @Default([]) List<String> compTags,
    @Default([]) List<String> quizTags,
  }) = _MyLibrary;
}