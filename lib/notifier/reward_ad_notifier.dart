import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vocab_blast/model/reward_ad_state.dart';
import 'dart:io';

class RewardAdNotifier extends StateNotifier<RewardAdState> {

  RewardAdNotifier() : super(const RewardAdState()) {
    createAd();
  }

  String rewardAdUnitId(){
    bool isDebug = false;
    assert(isDebug = true);

    if (isDebug) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/5224354917";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1712485313";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-9355531664192197/3236917056";
      } else if (Platform.isIOS) {
        return "ca-app-pub-9355531664192197/4810633423";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  void createAd() {
    RewardedAd.load(
        adUnitId: rewardAdUnitId(),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              state = state.copyWith(isLoaded: true, ad: ad);
              },
            onAdFailedToLoad: (LoadAdError error) {
              print('RewardedAd failed to load: $error');
            },
        ),
    );
  }

  Future<void> showAd(VoidCallback callback) async{
    if(state.ad == null){
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }

    state.ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );

    await state.ad!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        callback();
      },
    );
    state = state.copyWith(ad: null);
  }
}