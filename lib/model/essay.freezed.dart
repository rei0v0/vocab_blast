// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'essay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Essay {
  String get topic => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  bool get isValidInput => throw _privateConstructorUsedError;
  int get numWords => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EssayCopyWith<Essay> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EssayCopyWith<$Res> {
  factory $EssayCopyWith(Essay value, $Res Function(Essay) then) =
      _$EssayCopyWithImpl<$Res, Essay>;
  @useResult
  $Res call(
      {String topic,
      String content,
      String comment,
      bool isValidInput,
      int numWords});
}

/// @nodoc
class _$EssayCopyWithImpl<$Res, $Val extends Essay>
    implements $EssayCopyWith<$Res> {
  _$EssayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? content = null,
    Object? comment = null,
    Object? isValidInput = null,
    Object? numWords = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      isValidInput: null == isValidInput
          ? _value.isValidInput
          : isValidInput // ignore: cast_nullable_to_non_nullable
              as bool,
      numWords: null == numWords
          ? _value.numWords
          : numWords // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EssayCopyWith<$Res> implements $EssayCopyWith<$Res> {
  factory _$$_EssayCopyWith(_$_Essay value, $Res Function(_$_Essay) then) =
      __$$_EssayCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      String content,
      String comment,
      bool isValidInput,
      int numWords});
}

/// @nodoc
class __$$_EssayCopyWithImpl<$Res> extends _$EssayCopyWithImpl<$Res, _$_Essay>
    implements _$$_EssayCopyWith<$Res> {
  __$$_EssayCopyWithImpl(_$_Essay _value, $Res Function(_$_Essay) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? content = null,
    Object? comment = null,
    Object? isValidInput = null,
    Object? numWords = null,
  }) {
    return _then(_$_Essay(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      isValidInput: null == isValidInput
          ? _value.isValidInput
          : isValidInput // ignore: cast_nullable_to_non_nullable
              as bool,
      numWords: null == numWords
          ? _value.numWords
          : numWords // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Essay implements _Essay {
  const _$_Essay(
      {this.topic = '',
      this.content = '',
      this.comment = '',
      this.isValidInput = true,
      this.numWords = 0});

  @override
  @JsonKey()
  final String topic;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey()
  final String comment;
  @override
  @JsonKey()
  final bool isValidInput;
  @override
  @JsonKey()
  final int numWords;

  @override
  String toString() {
    return 'Essay(topic: $topic, content: $content, comment: $comment, isValidInput: $isValidInput, numWords: $numWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Essay &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isValidInput, isValidInput) ||
                other.isValidInput == isValidInput) &&
            (identical(other.numWords, numWords) ||
                other.numWords == numWords));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, topic, content, comment, isValidInput, numWords);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EssayCopyWith<_$_Essay> get copyWith =>
      __$$_EssayCopyWithImpl<_$_Essay>(this, _$identity);
}

abstract class _Essay implements Essay {
  const factory _Essay(
      {final String topic,
      final String content,
      final String comment,
      final bool isValidInput,
      final int numWords}) = _$_Essay;

  @override
  String get topic;
  @override
  String get content;
  @override
  String get comment;
  @override
  bool get isValidInput;
  @override
  int get numWords;
  @override
  @JsonKey(ignore: true)
  _$$_EssayCopyWith<_$_Essay> get copyWith =>
      throw _privateConstructorUsedError;
}
