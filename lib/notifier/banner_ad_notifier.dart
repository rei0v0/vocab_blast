import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vocab_blast/model/banner_ad_state.dart';
import 'dart:io';

final bannerAdProvider = StateNotifierProvider.autoDispose<BannerAdNotifier, BannerAdState>((ref) {
  return BannerAdNotifier();
});

class BannerAdNotifier extends StateNotifier<BannerAdState> {

  BannerAdNotifier() : super(const BannerAdState()) {
    createAd();
  }

  String bannerAdUnitId(){
    bool isDebug = false;
    assert(isDebug = true);

    if (isDebug) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/6300978111";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/2934735716";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-9355531664192197/6451018154";
      } else if (Platform.isIOS) {
        return "ca-app-pub-9355531664192197/6221160314";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  void createAd() {

    //state.ad?.dispose();
    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},

      ),
      size: AdSize.banner,
      adUnitId: bannerAdUnitId(),
      request: const AdRequest(),
    )..load();

    state = state.copyWith(ad: banner, isLoaded: true);

  }
}