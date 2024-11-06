import 'dart:io';
import 'package:app_task_demo/shared_preferences/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// A screen that displays a preview of an image with an optional banner ad.
///
/// The [ImagePreviewScreen]   shows  a full-screen image and, if the app is not
/// unlocked, displays a banner ad at the bottom of the screen. Users can close
/// the banner ad by tapping a close button.
///
/// This screen includes:
/// - A full-screen image preview.
/// - A banner ad that displays if the app is not unlocked, which can be closed.
///

class ImagePreviewScreen extends StatefulWidget {
  /// The path of the image to preview.
  final String? imagePath;

  /// Creates an [ImagePreviewScreen].
  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  ImagePreviewScreenState createState() => ImagePreviewScreenState();
}

class ImagePreviewScreenState extends State<ImagePreviewScreen> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isBannerVisible = true;
  bool _isAppUnlocked = false;

  /// The ad unit ID used for loading banner ads, depending on the platfor
  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    _checkUnlockStatus();
  }

  /// Checks if the app is unlocked by retrieving the unlock status from shared preferences
  ///
  /// If the a pp is unlocked, the banner ad will nott be displayed. If it is
  /// locked, this metho d initiates loading of the banner ad
  Future<void> _checkUnlockStatus() async {
    var isAppUnlocked = await PreferencesHelper.getIsAppUnlocked();

    setState(() {
      _isAppUnlocked = isAppUnlocked;
      _isBannerVisible = !isAppUnlocked;
    });

    // Only load the banner ad if the app is not unlocked
    if (!_isAppUnlocked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadBannerAd();
      });
    }
  }

  /// Loads a banner ad if the app is not unlocked.
  ///
  /// Initializes and loads the banner ad, setting up listeners to handle
  /// ad load success and failure
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner Ad failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full-screen image preview
        Positioned.fill(
          child: Image.file(
            File(widget.imagePath ?? ''),
            fit: BoxFit.cover,
          ),
        ),

        // Close button for the banner ad
        if (_isLoaded && _isBannerVisible)
          Positioned(
            right: 0,
            bottom: 70,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isBannerVisible = false; // Hide the banner when closed
                });
              },
              child: Container(
                width: 72,
                height: 26,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    'X',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),

        // Banner ad container
        if (_isLoaded && _isBannerVisible)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(width: 2, color: Colors.red),
                ),
              ),
              height: 70,
              child: _bannerAd != null
                  ? SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(
                        ad: _bannerAd!,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }
}
