// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DownloadFile {
  String get textId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  bool get isDownloading => throw _privateConstructorUsedError;
  bool get isExists => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DownloadFileCopyWith<DownloadFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadFileCopyWith<$Res> {
  factory $DownloadFileCopyWith(
          DownloadFile value, $Res Function(DownloadFile) then) =
      _$DownloadFileCopyWithImpl<$Res, DownloadFile>;
  @useResult
  $Res call(
      {String textId,
      String type,
      String size,
      bool isDownloading,
      bool isExists});
}

/// @nodoc
class _$DownloadFileCopyWithImpl<$Res, $Val extends DownloadFile>
    implements $DownloadFileCopyWith<$Res> {
  _$DownloadFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textId = null,
    Object? type = null,
    Object? size = null,
    Object? isDownloading = null,
    Object? isExists = null,
  }) {
    return _then(_value.copyWith(
      textId: null == textId
          ? _value.textId
          : textId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      isDownloading: null == isDownloading
          ? _value.isDownloading
          : isDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      isExists: null == isExists
          ? _value.isExists
          : isExists // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DownloadFileCopyWith<$Res>
    implements $DownloadFileCopyWith<$Res> {
  factory _$$_DownloadFileCopyWith(
          _$_DownloadFile value, $Res Function(_$_DownloadFile) then) =
      __$$_DownloadFileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String textId,
      String type,
      String size,
      bool isDownloading,
      bool isExists});
}

/// @nodoc
class __$$_DownloadFileCopyWithImpl<$Res>
    extends _$DownloadFileCopyWithImpl<$Res, _$_DownloadFile>
    implements _$$_DownloadFileCopyWith<$Res> {
  __$$_DownloadFileCopyWithImpl(
      _$_DownloadFile _value, $Res Function(_$_DownloadFile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textId = null,
    Object? type = null,
    Object? size = null,
    Object? isDownloading = null,
    Object? isExists = null,
  }) {
    return _then(_$_DownloadFile(
      textId: null == textId
          ? _value.textId
          : textId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      isDownloading: null == isDownloading
          ? _value.isDownloading
          : isDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      isExists: null == isExists
          ? _value.isExists
          : isExists // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DownloadFile implements _DownloadFile {
  const _$_DownloadFile(
      {this.textId = '',
      this.type = '',
      this.size = '取得中',
      this.isDownloading = false,
      this.isExists = false});

  @override
  @JsonKey()
  final String textId;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String size;
  @override
  @JsonKey()
  final bool isDownloading;
  @override
  @JsonKey()
  final bool isExists;

  @override
  String toString() {
    return 'DownloadFile(textId: $textId, type: $type, size: $size, isDownloading: $isDownloading, isExists: $isExists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DownloadFile &&
            (identical(other.textId, textId) || other.textId == textId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.isDownloading, isDownloading) ||
                other.isDownloading == isDownloading) &&
            (identical(other.isExists, isExists) ||
                other.isExists == isExists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, textId, type, size, isDownloading, isExists);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DownloadFileCopyWith<_$_DownloadFile> get copyWith =>
      __$$_DownloadFileCopyWithImpl<_$_DownloadFile>(this, _$identity);
}

abstract class _DownloadFile implements DownloadFile {
  const factory _DownloadFile(
      {final String textId,
      final String type,
      final String size,
      final bool isDownloading,
      final bool isExists}) = _$_DownloadFile;

  @override
  String get textId;
  @override
  String get type;
  @override
  String get size;
  @override
  bool get isDownloading;
  @override
  bool get isExists;
  @override
  @JsonKey(ignore: true)
  _$$_DownloadFileCopyWith<_$_DownloadFile> get copyWith =>
      throw _privateConstructorUsedError;
}
