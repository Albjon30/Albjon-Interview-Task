import 'package:app_task_demo/utilities/dialog/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Displays an error dialog with a customizable message.
///
/// The [showErrorDialog] function uses the [showGenericDialog] to display
/// an error message in a modal dialog. It has a single "OK" button that
/// closes the dialog without returning a value. This function is useful for
/// showing simple error alerts to the user.
///
/// - [context]: The [BuildContext] to display the dialog in.
/// - [text]: The error message text to display in the dialog content.
///
/// This function relies on localized strings from [AppLocalizations] for
/// the dialog title and button label.
///
/// Example:
/// ```dart
/// await showErrorDialog(
///   context,
///   'An unexpected error occurred. Please try again.',
/// );
/// ```
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: AppLocalizations.of(context).cameraError,
    content: text,
    optionBuilder: () => {
      AppLocalizations.of(context).ok: null,
    },
  );
}
