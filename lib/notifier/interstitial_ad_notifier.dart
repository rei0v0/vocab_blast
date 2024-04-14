import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vocab_blast/model/interstitial_ad_state.dart';
import 'dart:io';

final adProvider = StateNotifierProvider<InterstitialAdNotifier, InterstitialAdState>((ref) {
  return InterstitialAdNotifier();
});

class InterstitialAdNotifier extends StateNotifier<InterstitialAdState> {

  InterstitialAdNotifier() : super(const InterstitialAdState()) {
    createAd();
  }

  String interstitialAdUnitId(){
    bool isDebug = false;
    assert(isDebug = true);

    if (isDebug) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/1033173712";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-9355531664192197/4619061731";
      } else if (Platform.isIOS) {
        return "ca-app-pub-9355531664192197/4418136785";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  void createAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // 広告が正常にロードされたときに呼ばれます。
          onAdLoaded: (InterstitialAd ad) {
            state = state.copyWith(isLoaded: true, ad: ad);
          },
          // 広告のロードが失敗した際に呼ばれます。
          onAdFailedToLoad: (LoadAdError error) {

          },
        ),
    );
  }

  Future<void> showAd() async{
    if(state.ad == null){
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }

    state.ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print("ad Disposed");
        ad.dispose();
        createAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        print('$ad OnAdFailed $aderror');
        ad.dispose();
        createAd();
      },
    );

    await state.ad!.show();
    state = state.copyWith(ad: null);
  }
}