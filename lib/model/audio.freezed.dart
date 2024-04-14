// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Audio {
  String get wavFile => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  AudioPlayer? get player => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioCopyWith<Audio> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioCopyWith<$Res> {
  factory $AudioCopyWith(Audio value, $Res Function(Audio) then) =
      _$AudioCopyWithImpl<$Res, Audio>;
  @useResult
  $Res call({String wavFile, bool isPlaying, AudioPlayer? player});
}

/// @nodoc
class _$AudioCopyWithImpl<$Res, $Val extends Audio>
    implements $AudioCopyWith<$Res> {
  _$AudioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wavFile = null,
    Object? isPlaying = null,
    Object? player = freezed,
  }) {
    return _then(_value.copyWith(
      wavFile: null == wavFile
          ? _value.wavFile
          : wavFile // ignore: cast_nullable_to_non_nullable
              as String,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      player: freezed == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as AudioPlayer?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioCopyWith<$Res> implements $AudioCopyWith<$Res> {
  factory _$$_AudioCopyWith(_$_Audio value, $Res Function(_$_Audio) then) =
      __$$_AudioCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String wavFile, bool isPlaying, AudioPlayer? player});
}

/// @nodoc
class __$$_AudioCopyWithImpl<$Res> extends _$AudioCopyWithImpl<$Res, _$_Audio>
    implements _$$_AudioCopyWith<$Res> {
  __$$_AudioCopyWithImpl(_$_Audio _value, $Res Function(_$_Audio) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wavFile = null,
    Object? isPlaying = null,
    Object? player = freezed,
  }) {
    return _then(_$_Audio(
      wavFile: null == wavFile
          ? _value.wavFile
          : wavFile // ignore: cast_nullable_to_non_nullable
              as String,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      player: freezed == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as AudioPlayer?,
    ));
  }
}

/// @nodoc

class _$_Audio implements _Audio {
  const _$_Audio(
      {this.wavFile = '', this.isPlaying = false, this.player = null});

  @override
  @JsonKey()
  final String wavFile;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final AudioPlayer? player;

  @override
  String toString() {
    return 'Audio(wavFile: $wavFile, isPlaying: $isPlaying, player: $player)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Audio &&
            (identical(other.wavFile, wavFile) || other.wavFile == wavFile) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.player, player) || other.player == player));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wavFile, isPlaying, player);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioCopyWith<_$_Audio> get copyWith =>
      __$$_AudioCopyWithImpl<_$_Audio>(this, _$identity);
}

abstract class _Audio implements Audio {
  const factory _Audio(
      {final String wavFile,
      final bool isPlaying,
      final AudioPlayer? player}) = _$_Audio;

  @override
  String get wavFile;
  @override
  bool get isPlaying;
  @override
  AudioPlayer? get player;
  @override
  @JsonKey(ignore: true)
  _$$_AudioCopyWith<_$_Audio> get copyWith =>
      throw _privateConstructorUsedError;
}
