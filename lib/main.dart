import 'package:app_task_demo/routing/go_route.dart';
import 'package:app_task_demo/shared/constants/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    );
  }
}
