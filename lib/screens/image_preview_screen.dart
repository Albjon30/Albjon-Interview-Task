// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class ImagePreviewScreen extends StatefulWidget {
//   final String? imagePath;
//
//   const ImagePreviewScreen({super.key, required this.imagePath});
//
//   @override
//   ImagePreviewScreenState createState() => ImagePreviewScreenState();
// }
//
// class ImagePreviewScreenState extends State<ImagePreviewScreen> {
//   BannerAd? _bannerAd;
//   bool _isLoaded = false;
//   bool _isBannerVisible = true;
//   int _retryCount = 0;
//
//   final String adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-3940256099942544/6300978111'
//       : 'ca-app-pub-3940256099942544/2934735716';
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_)import 'dart:io';
//     import 'package:flutter/material.dart';
//     import 'package:google_mobile_ads/google_mobile_ads.dart';
//     import 'package:shared_preferences/shared_preferences.dart';
//
//     class ImagePreviewScreen extends StatefulWidget {
//     final String? imagePath;
//
//     const ImagePreviewScreen({super.key, required this.imagePath});
//
//     @override
//     ImagePreviewScreenState createState() => ImagePreviewScreenState();
//     }
//
//         class ImagePreviewScreenState extends State<ImagePreviewScreen> {
//         BannerAd? _bannerAd;
//         bool _isLoaded = false;
//         bool _isBannerVisible = true;
//         bool _isAppUnlocked = false;
//
//         final String adUnitId = Platform.isAndroid
//         ? 'ca-app-pub-3940256099942544/6300978111'
//             : 'ca-app-pub-3940256099942544/2934735716';
//
//         @override
//         void initState() {
//         super.initState();
//         _checkUnlockStatus();
//         }
//
//         Future<void> _checkUnlockStatus() async {
//         // Check if the app is unlocked in SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         bool isAppUnlocked = prefs.getBool('isAppUnlocked') ?? false;
//         setState(() {
//         _isAppUnlocked = isAppUnlocked;
//         _isBannerVisible = !isAppUnlocked;
//         });
//
//         // Only load the banner ad if the app is not unlocked
//         if (!_isAppUnlocked) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//         _loadBannerAd();
//         });
//         }
//         }
//
//         void _loadBannerAd() {
//         _bannerAd = BannerAd(
//         adUnitId: adUnitId,
//         size: AdSize.banner,
//         request: const AdRequest(),
//         listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//         print('Banner Ad loaded.');
//         setState(() {
//         _bannerAd = ad as BannerAd;
//         _isLoaded = true;
//         });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//         print('Banner Ad failed to load: $error');
//         ad.dispose();
//         },
//         ),
//         )..load();
//         }
//
//         @override
//         void dispose() {
//         _bannerAd?.dispose();
//         super.dispose();
//         }
//
//         @override
//         Widget build(BuildContext context) {
//         return Stack(
//         children: [
//         Positioned.fill(
//         child: Image.file(
//         File(widget.imagePath ?? ''),
//         fit: BoxFit.cover,
//         ),
//         ),
//         if (_isBannerVisible)
//         Positioned(
//         right: 0,
//         bottom: 70,
//         child: Container(
//         width: 72,
//         height: 26,
//         decoration: const BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         ),
//         child: Center(
//         child: GestureDetector(
//         onTap: () {
//         setState(() {
//         _isBannerVisible = false; // Hide the banner when closed
//         });
//         },
//         child: Text(
//         'X',
//         style: TextStyle(
//         color: Colors.white,
//         fontSize: 18,
//         fontWeight: FontWeight.w900,
//         ),
//         ),
//         ),
//         ),
//         ),
//         ),
//         if (_isLoaded && _isBannerVisible)
//         Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//         color: Colors.black,
//         border: Border(
//         top: BorderSide(width: 2, color: Colors.red),
//         ),
//         ),
//         height: 70,
//         child: _bannerAd != null
//         ? SizedBox(
//         width: _bannerAd!.size.width.toDouble(),
//         height: _bannerAd!.size.height.toDouble(),
//         child: AdWidget(ad: _bannerAd!),
//         )
//             : const SizedBox.shrink(),
//         ),
//         ),
//         ],
//         );
//         }
//         }
//         {
//       _loadBannerAd();
//     });
//   }
//
//   void _loadBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: adUnitId,
//       size: AdSize.banner, // Standard banner size
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('Banner Ad loaded.-----------------------------------------');
//           setState(() {
//             _bannerAd = ad as BannerAd;
//             _isLoaded = true;
//             _retryCount = 0;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print(
//               'Banner Ad failed to load: $error--------------------------------------------------');
//           ad.dispose();
//           _retryCount++;
//           if (_retryCount < 3) {
//             Future.delayed(const Duration(seconds: 3), _loadBannerAd);
//           } else {
//             print(
//                 "Failed to load ad after $_retryCount attempts.==========================================");
//           }
//         },
//       ),
//     )..load();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Image.file(
//             File(widget.imagePath ?? ''),
//             fit: BoxFit.cover,
//           ),
//         ),
//         if (_isBannerVisible)
//           Positioned(
//             right: 0,
//             bottom: 70,
//             child: Container(
//               width: 72,
//               height: 26,
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//               child: Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _isBannerVisible = false; // Hide the banner when closed
//                     });
//                   },
//                   child: Text(
//                     'X',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         if (_isLoaded && _isBannerVisible)
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 border: Border(
//                   top: BorderSide(width: 2, color: Colors.red),
//                 ),
//               ),
//               height: 70,
//               child: _bannerAd != null
//                   ? SizedBox(
//                       width: _bannerAd!.size.width.toDouble(),
//                       height: _bannerAd!.size.height.toDouble(),
//                       child: AdWidget(ad: _bannerAd!),
//                     )
//                   : const SizedBox.shrink(),
//             ),
//           )
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String? imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  ImagePreviewScreenState createState() => ImagePreviewScreenState();
}

class ImagePreviewScreenState extends State<ImagePreviewScreen> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isBannerVisible = true;
  bool _isAppUnlocked = false;

  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    _checkUnlockStatus();
  }

  Future<void> _checkUnlockStatus() async {
    // Check if the app i s unlocked in SharedPrefgerences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAppUnlocked = prefs.getBool('isAppUnlocked') ?? false;
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

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Banner Ad loaded.');
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
        Positioned.fill(
          child: Image.file(
            File(widget.imagePath ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        if (_isLoaded && _isBannerVisible)
          Positioned(
            right: 0,
            bottom: 70,
            child: Container(
              width: 72,
              height: 26,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isBannerVisible = false; // Hide the banner when closed
                    });
                  },
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
                      child: AdWidget(ad: _bannerAd!),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }
}
