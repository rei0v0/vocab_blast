import 'package:freezed_annotation/freezed_annotation.dart';
part 'essay.freezed.dart';

@freezed
abstract class Essay with _$Essay {
  const factory Essay({
    @Default('') String topic,
    @Default('') String content,
    @Default('') String comment,
    @Default(true) bool isValidInput,
    @Default(0) int numWords,
  }) = _Essay;
}