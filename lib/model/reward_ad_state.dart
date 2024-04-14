import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
part 'reward_ad_state.freezed.dart';

@freezed
abstract class RewardAdState with _$RewardAdState{
  const factory RewardAdState({
    @Default(null) RewardedAd? ad,
    @Default(false) bool isLoaded,
  }) = _RewardAdState;
}