import 'package:app_task_demo/routing/go_route.dart';
import 'package:app_task_demo/shared/constants/themes/themes.dart';
import 'package:app_task_demo/utilities/dialog/error_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Main entry point of the application.
///
/// Initializes the Google Mobile Ads SDk and starts the app. If initialization
/// fails, it passes a flag to `MyApop` to show an error dialog.
/// Initializes the firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();
  bool adsInitialized = true;

  // Set up Crashlytics to capture Flutter errors
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  //TODO remove it if production
  /// By default, Crashlytics only collects reports in release mode.
  /// Wee can enable it in debug mode for testing purposes:
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Attempt to initialize Google Mobile Ads SDK.
  try {
    await MobileAds.instance.initialize();
  } catch (e, stackTrace) {
    FirebaseCrashlytics.instance.recordError(e, stackTrace,
        reason: 'Failed to initialize Google Mobile Ads:');

    adsInitialized = false;
  }

  // Run the app, passing the initialization status to MyApp.
  runApp(MyApp(adsInitialized: adsInitialized));
}

/// Root widget of the application.
///
/// [MyApp] configures the app with routing, localization, and theme support. If
/// the Google Mobile Ads SDK failed to initialize, it shows an error dialog on
/// the home screen informing the user.
class MyApp extends StatelessWidget {
  /// Indicates whether the Google Mobile Ads SDK was successfully initialized.
  final bool adsInitialized;

  const MyApp({super.key, required this.adsInitialized});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: const Locale('ar'), // Set Arabic as the default language
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      theme: CustomTheme.lightTheme,
      themeMode: currentTheme.getTheme(),
      darkTheme: CustomTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        // Use a post-frame callback to show the dialog after the first frame.
        if (!adsInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showErrorDialog(
              context,
              "Failed to initialize ads. Some features may not work.",
            );
          });
        }
        return child!;
      },
    );
  }
}
