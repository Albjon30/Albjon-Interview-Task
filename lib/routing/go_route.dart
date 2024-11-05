import 'package:app_task_demo/app_bar.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:app_task_demo/screens/add_photo_screen.dart';
import 'package:app_task_demo/screens/birthday_screen.dart';
import 'package:app_task_demo/screens/camera_screen.dart';
import 'package:app_task_demo/screens/gender_screen.dart';
import 'package:app_task_demo/screens/image_preview_screen.dart';
import 'package:app_task_demo/screens/nickname_screen.dart';
import 'package:app_task_demo/screens/settings_screen.dart';
import 'package:app_task_demo/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = routerWithLocation();
final GlobalKey<NavigatorState> routerNavigationKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class CustomTransition extends CustomTransitionPage<void> {
  CustomTransition({
    super.key,
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 70),
          reverseTransitionDuration: const Duration(milliseconds: 0),
          maintainState: false,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              alwaysIncludeSemantics: true,
              opacity: animation.drive(CurveTween(curve: Curves.ease)),
              child: child,
            );
          },
        );
}

/// The route configuration.
GoRouter routerWithLocation({
  String? initialLocation,
}) {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  return GoRouter(
    navigatorKey: routerNavigationKey,
    initialLocation: Routes.splashScreen,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          return AppBarWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.splashScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const SplashScreen());
            },
          ),
          GoRoute(
            path: Routes.birthdayScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const BirthdayScreen());
            },
          ),
          GoRoute(
            path: Routes.nicknameScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const NicknameScreen());
            },
          ),
          GoRoute(
            path: Routes.genderScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const GenderSelectionScreen());
            },
          ),
          GoRoute(
            path: Routes.addPhotoScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const PhotoScreen());
            },
          ),
          GoRoute(
            path: Routes.cameraScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const CameraScreen());
            },
          ),
          GoRoute(
            path: Routes.settingsScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransition(child: const SettingsScreen());
            },
          ),
          GoRoute(
            path: Routes.imagePreviewScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String? imagePath =
                  (state.extra as Map<String, dynamic>?)?['imagePath'];
              return CustomTransition(
                  child: ImagePreviewScreen(
                imagePath: imagePath ?? '',
              ));
            },
          ),
        ],
      ),
    ],
  );
}

String getCurrentRoute(BuildContext context) {
  var location = '';
  try {
    location = GoRouterState.of(context).uri.path;
  } catch (e) {
    if (kDebugMode) {
      print('Missing go Router State');
    }
  }
  return location;
}
