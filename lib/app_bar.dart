import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/go_route.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/// A wrapper that provides a customizable app bar with a child widget.
///
/// The [AppBarWrapper] disp lays a background image or color based on the
/// current screen route, includes an optional child widget, and dynamically
/// displays app bar actions and a leading button.
///
/// - For certain full-screen routes (like the camera or image preview),
///   the app bar is hidden.
/// - Other screens display app bar actions like progress indicators and a
///   settings icon.
///
///
class AppBarWrapper extends StatelessWidget {
  /// The child widget to display in the body of the screen.
  final Widget? child;

  /// Creates an [AppBarWrapper].
  const AppBarWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    var screen = getCurrentRoute(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          // Background customization based on screen
          (screen == Routes.settingsScreen)
              ? Container(color: Colors.black)
              : const BackgroundImage(
                  image: "assets/onboarding_background.jpg",
                ),

          // Main content area with SafeArea for non-fullscree n screens
          if (!_isFullScreen(screen))
            SafeArea(
              child: ContentAlignment(
                child: child ?? const SizedBox.shrink(),
              ),
            )
          else
            child ?? const SizedBox.shrink(),

          // AppBar with actions and leading button for non-splash screens
          if (screen != Routes.splashScreen)
            Positioned(
              top: 20,
              left: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const LeadingButton(),
                        const Spacer(),
                        AppBarActions(screen: screen),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Determines if the current screen sh ould display in full-screen mode.
  ///
  /// Returns true if the screen should not display the app bar.
  bool _isFullScreen(String screen) {
    return screen == Routes.cameraScreen ||
        screen == Routes.imagePreviewScreen ||
        screen == Routes.splashScreen;
  }
}

/// A button that serves as the leading button in the app bar.
///
/// The [LeadingButton] shows an icon based on whether the keyboard is visible:
/// - If the keyboard is visib  le, a close icon is shown to hide the keyboard
/// - If not, an arrow icon is displayed to nav igate back
class LeadingButton extends StatefulWidget {
  /// Creates a [LeadingButton].
  const LeadingButton({super.key});

  @override
  State<LeadingButton> createState() => _LeadingButtonState();
}

class _LeadingButtonState extends State<LeadingButton>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isKeyboardVisible = WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Listens for changes in metrics to detect keyboard visibility.
  @override
  void didChangeMetrics() {
    final isKeyboardVisible =
        WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
    if (isKeyboardVisible != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = isKeyboardVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: GestureDetector(
        onTap: () {
          if (_isKeyboardVisible) {
            FocusManager.instance.primaryFocus?.unfocus();
          } else {
            context.pop();
          }
        },
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Icon(
              _isKeyboardVisible ? Icons.close : Icons.arrow_back,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that displays app bar actions based on the current screen.
///
/// The [AppBarActions] widget shows:
/// = A settings icon for certain screens.
/// = A progress indicator for onboarding screens, indicating completion
///
/// The displayed actions vary depending on the screen.
class AppBarActions extends StatefulWidget {
  /// The current screen route name.
  final String screen;

  /// Creates an [AppBarActions] widget.
  const AppBarActions({super.key, required this.screen});

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = _calculateProgress(widget.screen);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Row(
        children: _buildActions(context),
      ),
    );
  }

  /// Builds the list of action widgets based on the screen.
  ///
  /// Returns a list of widgets to display in the app bar.
  List<Widget> _buildActions(BuildContext context) {
    switch (widget.screen) {
      case Routes.imagePreviewScreen:
        return [
          _buildCircleIcon(
            icon: Icons.settings_outlined,
            onTap: () => context.push(Routes.settingsScreen),
          ),
        ];
      case Routes.birthdayScreen:
      case Routes.genderScreen:
      case Routes.addPhotoScreen:
      case Routes.nicknameScreen:
        return [
          CircularPercentIndicator(
            radius: 23.0,
            lineWidth: 1.0,
            percent: progress,
            animation: false,
            backgroundColor: Colors.grey.shade800,
            center: Text(
              "${(progress * 100).toInt()}%",
              style: const TextStyle(
                color: Color.fromRGBO(149, 149, 149, 1),
              ),
            ),
            progressColor: Colors.white,
          ),
        ];
      default:
        return [];
    }
  }

  /// Calculates the progress for onboarding screens based on the screen route.
  ///
  /// Returns a double value representing the completion percentage.
  double _calculateProgress(String screen) {
    switch (screen) {
      case Routes.birthdayScreen:
        return 0.25;
      case Routes.nicknameScreen:
        return 0.50;
      case Routes.genderScreen:
        return 0.75;
      case Routes.addPhotoScreen:
        return 1.0;
      default:
        return 0.0;
    }
  }

  /// Builds a circular icon button with the given icon and [onTap] callback.
  Widget _buildCircleIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
        ),
        child: Icon(icon, color: Colors.white.withOpacity(0.8)),
      ),
    );
  }
}
