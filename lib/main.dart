import 'package:app_task_demo/routing/go_route.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
      theme: ThemeData(
        fontFamily: 'Lato', // Set Lato as the default font family
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w400), // Regular
          bodySmall: TextStyle(fontWeight: FontWeight.w300), // Light
          headlineMedium: TextStyle(fontWeight: FontWeight.w700), // Bold
        ),
      ),
    );
  }
}
