// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interstitial_ad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InterstitialAdState {
  InterstitialAd? get ad => throw _privateConstructorUsedError;
  bool get isLoaded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InterstitialAdStateCopyWith<InterstitialAdState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterstitialAdStateCopyWith<$Res> {
  factory $InterstitialAdStateCopyWith(
          InterstitialAdState value, $Res Function(InterstitialAdState) then) =
      _$InterstitialAdStateCopyWithImpl<$Res, InterstitialAdState>;
  @useResult
  $Res call({InterstitialAd? ad, bool isLoaded});
}

/// @nodoc
class _$InterstitialAdStateCopyWithImpl<$Res, $Val extends InterstitialAdState>
    implements $InterstitialAdStateCopyWith<$Res> {
  _$InterstitialAdStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ad = freezed,
    Object? isLoaded = null,
  }) {
    return _then(_value.copyWith(
      ad: freezed == ad
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as InterstitialAd?,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InterstitialAdStateCopyWith<$Res>
    implements $InterstitialAdStateCopyWith<$Res> {
  factory _$$_InterstitialAdStateCopyWith(_$_InterstitialAdState value,
          $Res Function(_$_InterstitialAdState) then) =
      __$$_InterstitialAdStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InterstitialAd? ad, bool isLoaded});
}

/// @nodoc
class __$$_InterstitialAdStateCopyWithImpl<$Res>
    extends _$InterstitialAdStateCopyWithImpl<$Res, _$_InterstitialAdState>
    implements _$$_InterstitialAdStateCopyWith<$Res> {
  __$$_InterstitialAdStateCopyWithImpl(_$_InterstitialAdState _value,
      $Res Function(_$_InterstitialAdState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ad = freezed,
    Object? isLoaded = null,
  }) {
    return _then(_$_InterstitialAdState(
      ad: freezed == ad
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as InterstitialAd?,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_InterstitialAdState implements _InterstitialAdState {
  const _$_InterstitialAdState({this.ad = null, this.isLoaded = false});

  @override
  @JsonKey()
  final InterstitialAd? ad;
  @override
  @JsonKey()
  final bool isLoaded;

  @override
  String toString() {
    return 'InterstitialAdState(ad: $ad, isLoaded: $isLoaded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InterstitialAdState &&
            (identical(other.ad, ad) || other.ad == ad) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ad, isLoaded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InterstitialAdStateCopyWith<_$_InterstitialAdState> get copyWith =>
      __$$_InterstitialAdStateCopyWithImpl<_$_InterstitialAdState>(
          this, _$identity);
}

abstract class _InterstitialAdState implements InterstitialAdState {
  const factory _InterstitialAdState(
      {final InterstitialAd? ad, final bool isLoaded}) = _$_InterstitialAdState;

  @override
  InterstitialAd? get ad;
  @override
  bool get isLoaded;
  @override
  @JsonKey(ignore: true)
  _$$_InterstitialAdStateCopyWith<_$_InterstitialAdState> get copyWith =>
      throw _privateConstructorUsedError;
}
