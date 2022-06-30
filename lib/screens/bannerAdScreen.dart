import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdScreen extends StatefulWidget {
  const BannerAdScreen({Key? key}) : super(key: key);

  @override
  State<BannerAdScreen> createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  //! banner ads

  final AdSize adSize = AdSize(height: 300, width: 60);
  BannerAd? myBanner;

  loadBannerAd() {
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: showBannerAd(),
    );
    myBanner!.load();
  }

  showBannerAd() {
    final BannerAdListener listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    );
  }

  Container createBannerWidget() {
    // make ad widget
    final AdWidget adWidget = AdWidget(ad: myBanner!);

//making ad container
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner!.size.width.toDouble(),
      height: myBanner!.size.height.toDouble(),
    );
    return adContainer;
  }

  @override
  void initState() {
    loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Banner Ad"),
      ),
      body: Center(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: myBanner == null
            ? Text("Cant made banner ad")
            : createBannerWidget(),
      )),
    );
  }
}
