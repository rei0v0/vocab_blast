// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserSetting {
  String get uid => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get token => throw _privateConstructorUsedError;
  int get times => throw _privateConstructorUsedError;
  int get numQuizzes => throw _privateConstructorUsedError;
  bool get isRandom => throw _privateConstructorUsedError;
  bool get onlyUnlearnedQuizzes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserSettingCopyWith<UserSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingCopyWith<$Res> {
  factory $UserSettingCopyWith(
          UserSetting value, $Res Function(UserSetting) then) =
      _$UserSettingCopyWithImpl<$Res, UserSetting>;
  @useResult
  $Res call(
      {String uid,
      int limit,
      int token,
      int times,
      int numQuizzes,
      bool isRandom,
      bool onlyUnlearnedQuizzes});
}

/// @nodoc
class _$UserSettingCopyWithImpl<$Res, $Val extends UserSetting>
    implements $UserSettingCopyWith<$Res> {
  _$UserSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? limit = null,
    Object? token = null,
    Object? times = null,
    Object? numQuizzes = null,
    Object? isRandom = null,
    Object? onlyUnlearnedQuizzes = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as int,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as int,
      numQuizzes: null == numQuizzes
          ? _value.numQuizzes
          : numQuizzes // ignore: cast_nullable_to_non_nullable
              as int,
      isRandom: null == isRandom
          ? _value.isRandom
          : isRandom // ignore: cast_nullable_to_non_nullable
              as bool,
      onlyUnlearnedQuizzes: null == onlyUnlearnedQuizzes
          ? _value.onlyUnlearnedQuizzes
          : onlyUnlearnedQuizzes // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserSettingCopyWith<$Res>
    implements $UserSettingCopyWith<$Res> {
  factory _$$_UserSettingCopyWith(
          _$_UserSetting value, $Res Function(_$_UserSetting) then) =
      __$$_UserSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      int limit,
      int token,
      int times,
      int numQuizzes,
      bool isRandom,
      bool onlyUnlearnedQuizzes});
}

/// @nodoc
class __$$_UserSettingCopyWithImpl<$Res>
    extends _$UserSettingCopyWithImpl<$Res, _$_UserSetting>
    implements _$$_UserSettingCopyWith<$Res> {
  __$$_UserSettingCopyWithImpl(
      _$_UserSetting _value, $Res Function(_$_UserSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? limit = null,
    Object? token = null,
    Object? times = null,
    Object? numQuizzes = null,
    Object? isRandom = null,
    Object? onlyUnlearnedQuizzes = null,
  }) {
    return _then(_$_UserSetting(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as int,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as int,
      numQuizzes: null == numQuizzes
          ? _value.numQuizzes
          : numQuizzes // ignore: cast_nullable_to_non_nullable
              as int,
      isRandom: null == isRandom
          ? _value.isRandom
          : isRandom // ignore: cast_nullable_to_non_nullable
              as bool,
      onlyUnlearnedQuizzes: null == onlyUnlearnedQuizzes
          ? _value.onlyUnlearnedQuizzes
          : onlyUnlearnedQuizzes // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_UserSetting implements _UserSetting {
  const _$_UserSetting(
      {this.uid = '',
      this.limit = 0,
      this.token = 0,
      this.times = 0,
      this.numQuizzes = 5,
      this.isRandom = false,
      this.onlyUnlearnedQuizzes = true});

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int token;
  @override
  @JsonKey()
  final int times;
  @override
  @JsonKey()
  final int numQuizzes;
  @override
  @JsonKey()
  final bool isRandom;
  @override
  @JsonKey()
  final bool onlyUnlearnedQuizzes;

  @override
  String toString() {
    return 'UserSetting(uid: $uid, limit: $limit, token: $token, times: $times, numQuizzes: $numQuizzes, isRandom: $isRandom, onlyUnlearnedQuizzes: $onlyUnlearnedQuizzes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserSetting &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.times, times) || other.times == times) &&
            (identical(other.numQuizzes, numQuizzes) ||
                other.numQuizzes == numQuizzes) &&
            (identical(other.isRandom, isRandom) ||
                other.isRandom == isRandom) &&
            (identical(other.onlyUnlearnedQuizzes, onlyUnlearnedQuizzes) ||
                other.onlyUnlearnedQuizzes == onlyUnlearnedQuizzes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, limit, token, times,
      numQuizzes, isRandom, onlyUnlearnedQuizzes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserSettingCopyWith<_$_UserSetting> get copyWith =>
      __$$_UserSettingCopyWithImpl<_$_UserSetting>(this, _$identity);
}

abstract class _UserSetting implements UserSetting {
  const factory _UserSetting(
      {final String uid,
      final int limit,
      final int token,
      final int times,
      final int numQuizzes,
      final bool isRandom,
      final bool onlyUnlearnedQuizzes}) = _$_UserSetting;

  @override
  String get uid;
  @override
  int get limit;
  @override
  int get token;
  @override
  int get times;
  @override
  int get numQuizzes;
  @override
  bool get isRandom;
  @override
  bool get onlyUnlearnedQuizzes;
  @override
  @JsonKey(ignore: true)
  _$$_UserSettingCopyWith<_$_UserSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
