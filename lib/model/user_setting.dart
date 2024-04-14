import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_setting.freezed.dart';

@freezed
abstract class UserSetting with _$UserSetting {
  const factory UserSetting({
    @Default('') String uid,
    @Default(0) int limit,
    @Default(0) int token,
    @Default(0) int times,
    @Default(5) int numQuizzes,
    @Default(false) bool isRandom,
    @Default(true) bool onlyUnlearnedQuizzes,
  }) = _UserSetting;
}