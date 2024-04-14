// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Book {
  List<Vocab> get vocabBook => throw _privateConstructorUsedError;
  List<Sentence> get compBook => throw _privateConstructorUsedError;
  List<Quiz> get quizBook => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {List<Vocab> vocabBook, List<Sentence> compBook, List<Quiz> quizBook});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vocabBook = null,
    Object? compBook = null,
    Object? quizBook = null,
  }) {
    return _then(_value.copyWith(
      vocabBook: null == vocabBook
          ? _value.vocabBook
          : vocabBook // ignore: cast_nullable_to_non_nullable
              as List<Vocab>,
      compBook: null == compBook
          ? _value.compBook
          : compBook // ignore: cast_nullable_to_non_nullable
              as List<Sentence>,
      quizBook: null == quizBook
          ? _value.quizBook
          : quizBook // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$_BookCopyWith(_$_Book value, $Res Function(_$_Book) then) =
      __$$_BookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Vocab> vocabBook, List<Sentence> compBook, List<Quiz> quizBook});
}

/// @nodoc
class __$$_BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res, _$_Book>
    implements _$$_BookCopyWith<$Res> {
  __$$_BookCopyWithImpl(_$_Book _value, $Res Function(_$_Book) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vocabBook = null,
    Object? compBook = null,
    Object? quizBook = null,
  }) {
    return _then(_$_Book(
      vocabBook: null == vocabBook
          ? _value._vocabBook
          : vocabBook // ignore: cast_nullable_to_non_nullable
              as List<Vocab>,
      compBook: null == compBook
          ? _value._compBook
          : compBook // ignore: cast_nullable_to_non_nullable
              as List<Sentence>,
      quizBook: null == quizBook
          ? _value._quizBook
          : quizBook // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
    ));
  }
}

/// @nodoc

class _$_Book implements _Book {
  const _$_Book(
      {final List<Vocab> vocabBook = const [],
      final List<Sentence> compBook = const [],
      final List<Quiz> quizBook = const []})
      : _vocabBook = vocabBook,
        _compBook = compBook,
        _quizBook = quizBook;

  final List<Vocab> _vocabBook;
  @override
  @JsonKey()
  List<Vocab> get vocabBook {
    if (_vocabBook is EqualUnmodifiableListView) return _vocabBook;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vocabBook);
  }

  final List<Sentence> _compBook;
  @override
  @JsonKey()
  List<Sentence> get compBook {
    if (_compBook is EqualUnmodifiableListView) return _compBook;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_compBook);
  }

  final List<Quiz> _quizBook;
  @override
  @JsonKey()
  List<Quiz> get quizBook {
    if (_quizBook is EqualUnmodifiableListView) return _quizBook;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quizBook);
  }

  @override
  String toString() {
    return 'Book(vocabBook: $vocabBook, compBook: $compBook, quizBook: $quizBook)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Book &&
            const DeepCollectionEquality()
                .equals(other._vocabBook, _vocabBook) &&
            const DeepCollectionEquality().equals(other._compBook, _compBook) &&
            const DeepCollectionEquality().equals(other._quizBook, _quizBook));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_vocabBook),
      const DeepCollectionEquality().hash(_compBook),
      const DeepCollectionEquality().hash(_quizBook));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookCopyWith<_$_Book> get copyWith =>
      __$$_BookCopyWithImpl<_$_Book>(this, _$identity);
}

abstract class _Book implements Book {
  const factory _Book(
      {final List<Vocab> vocabBook,
      final List<Sentence> compBook,
      final List<Quiz> quizBook}) = _$_Book;

  @override
  List<Vocab> get vocabBook;
  @override
  List<Sentence> get compBook;
  @override
  List<Quiz> get quizBook;
  @override
  @JsonKey(ignore: true)
  _$$_BookCopyWith<_$_Book> get copyWith => throw _privateConstructorUsedError;
}
