import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  RewardedAd? _rewardedAd;

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ad unit ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
        },
      ),
    );
  }

  void showRewardedAd(Function onAdWatched) {
    if (_rewardedAd == null) {
      onAdWatched(); // Call the callback directly if the ad is not loaded
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        loadRewardedAd();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        onAdWatched();
      },
    );
    _rewardedAd = null;
  }
}
