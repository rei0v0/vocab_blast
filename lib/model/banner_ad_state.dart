import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
part 'banner_ad_state.freezed.dart';

@freezed
abstract class BannerAdState with _$BannerAdState{
  const factory BannerAdState({
    @Default(null) BannerAd? ad,
    @Default(false) bool isLoaded,
  }) = _BannerAdState;
}