import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
part 'interstitial_ad_state.freezed.dart';

@freezed
abstract class InterstitialAdState with _$InterstitialAdState{
  const factory InterstitialAdState({
    @Default(null) InterstitialAd? ad,
    @Default(false) bool isLoaded,
  }) = _InterstitialAdState;
}