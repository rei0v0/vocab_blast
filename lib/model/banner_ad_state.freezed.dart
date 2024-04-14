// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_ad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BannerAdState {
  BannerAd? get ad => throw _privateConstructorUsedError;
  bool get isLoaded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BannerAdStateCopyWith<BannerAdState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerAdStateCopyWith<$Res> {
  factory $BannerAdStateCopyWith(
          BannerAdState value, $Res Function(BannerAdState) then) =
      _$BannerAdStateCopyWithImpl<$Res, BannerAdState>;
  @useResult
  $Res call({BannerAd? ad, bool isLoaded});
}

/// @nodoc
class _$BannerAdStateCopyWithImpl<$Res, $Val extends BannerAdState>
    implements $BannerAdStateCopyWith<$Res> {
  _$BannerAdStateCopyWithImpl(this._value, this._then);

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
              as BannerAd?,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BannerAdStateCopyWith<$Res>
    implements $BannerAdStateCopyWith<$Res> {
  factory _$$_BannerAdStateCopyWith(
          _$_BannerAdState value, $Res Function(_$_BannerAdState) then) =
      __$$_BannerAdStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BannerAd? ad, bool isLoaded});
}

/// @nodoc
class __$$_BannerAdStateCopyWithImpl<$Res>
    extends _$BannerAdStateCopyWithImpl<$Res, _$_BannerAdState>
    implements _$$_BannerAdStateCopyWith<$Res> {
  __$$_BannerAdStateCopyWithImpl(
      _$_BannerAdState _value, $Res Function(_$_BannerAdState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ad = freezed,
    Object? isLoaded = null,
  }) {
    return _then(_$_BannerAdState(
      ad: freezed == ad
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as BannerAd?,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BannerAdState implements _BannerAdState {
  const _$_BannerAdState({this.ad = null, this.isLoaded = false});

  @override
  @JsonKey()
  final BannerAd? ad;
  @override
  @JsonKey()
  final bool isLoaded;

  @override
  String toString() {
    return 'BannerAdState(ad: $ad, isLoaded: $isLoaded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BannerAdState &&
            (identical(other.ad, ad) || other.ad == ad) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ad, isLoaded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BannerAdStateCopyWith<_$_BannerAdState> get copyWith =>
      __$$_BannerAdStateCopyWithImpl<_$_BannerAdState>(this, _$identity);
}

abstract class _BannerAdState implements BannerAdState {
  const factory _BannerAdState({final BannerAd? ad, final bool isLoaded}) =
      _$_BannerAdState;

  @override
  BannerAd? get ad;
  @override
  bool get isLoaded;
  @override
  @JsonKey(ignore: true)
  _$$_BannerAdStateCopyWith<_$_BannerAdState> get copyWith =>
      throw _privateConstructorUsedError;
}
