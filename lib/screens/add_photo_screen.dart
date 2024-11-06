import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A screen that prompts the user to add a photo and provides guidelines.
///
/// The [PhotoScreen] displays a title, a button to take a photo, and a set of
/// photo guidelines to assist the user in taking a valid photo. It is a
/// stateless widget that relies on localization for its text strings.
///
/// This screen includes:
/// - A title prompt instructing the user to add a photo.
/// - A button that navigates to a camera screen.
/// - A list of guidelines to ensure the photo meets the required standards.
class PhotoScreen extends StatelessWidget {
  /// Creates a [PhotoScreen].
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Displays the title prompt for adding a photo
        Text(
          AppLocalizations.of(context).addPhotoPrompt,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 40),

        // Button that navigates to the camera screen for taking a photo
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              context.push(Routes.cameraScreen);
            },
            child: Text(
              AppLocalizations.of(context).takePhotoButton,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.scrim),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Container for displaying photo guidelines to the user
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header for the photo guidelines
              Text(AppLocalizations.of(context).photoGuidelineHeader,
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 10),

              // Guideline items for photo requirements
              buildGuidelineText(
                  AppLocalizations.of(context).photoGuidelineFace, context),
              buildGuidelineText(
                  AppLocalizations.of(context).photoGuidelineSingle, context),
              buildGuidelineText(
                  AppLocalizations.of(context).photoGuidelineReal, context),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a [Text] widget where it displays a photo guide line with consistent styling
  ///
  /// The [text] parameter contanis the guideline text to display. The [context]
  /// parameter provides the theme context for consistent styling across the app
  ///
  /// Returns a [Padding] widg et wrapping a [Text] widget with styling
  Widget buildGuidelineText(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}
