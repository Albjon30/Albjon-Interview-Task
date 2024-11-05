import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/go_route.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AppBarWrapper extends StatelessWidget {
  final Widget? child;

  const AppBarWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    var screen = getCurrentRoute(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BackgroundImage(
              image: screen != Routes.splashScreen
                  ? "assets/onboarding_background.jpg"
                  : "assets/splash_screen.jpg",
            ),
          ),
          if (screen != Routes.cameraScreen &&
              screen != Routes.imagePreviewScreen &&
              screen != Routes.splashScreen) ...{
            SafeArea(
              child: ContentAlignment(
                child: child ?? const SizedBox.shrink(),
              ),
            )
          } else ...{
            child ?? const SizedBox.shrink()
          },
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
}

class LeadingButton extends StatelessWidget {
  const LeadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        View.of(context).viewInsets.bottom > 0.0
            ? FocusManager.instance.primaryFocus?.unfocus()
            : context.pop(context);
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
              color: const Color.fromRGBO(149, 149, 149, 1), width: 1),
        ),
        child: Icon(
          View.of(context).viewInsets.bottom > 0.0
              ? Icons.close
              : Icons.arrow_back,
          color: const Color.fromRGBO(149, 149, 149, 1),
        ),
      ),
    );
  }
}

class AppBarActions extends StatefulWidget {
  final String screen;

  const AppBarActions({super.key, required this.screen});

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  late double progress;

  @override
  void initState() {
    super.initState();
    // Set the progres value here only once to prevent resetting the animtion
    progress = percentage(widget.screen);
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

  List<Widget> _buildActions(BuildContext context) {
    switch (widget.screen) {
      case Routes.imagePreviewScreen:
        return [
          _buildCircleIcon(
            icon: Icons.settings_outlined,
            onTap: () => context.push(Routes.settingsScreen),
          ),
        ];
      case Routes.birthdayScreen ||
            Routes.genderScreen ||
            Routes.addPhotoScreen ||
            Routes.nicknameScreen:
        return [
          CircularPercentIndicator(
            radius: 23.0,
            lineWidth: 1.0,
            percent: progress,
            animation: false,
            animationDuration: 1000,
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

  double percentage(screen) {
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
          border: Border.all(
              color: const Color.fromRGBO(149, 149, 149, 1), width: 1),
        ),
        child: Icon(
          icon,
          color: const Color.fromRGBO(149, 149, 149, 1),
        ),
      ),
    );
  }
}
