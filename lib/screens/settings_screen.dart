import 'package:app_task_demo/shared_preferences/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A screen that displays settings and account information, with options to
/// unlock premium features and rate the app
///
/// The [SettingsScreen] provides the following features:
/// - Display of the user's nickname and birthday.
/// - Option to unlock the app's premium features if not already unlocked
/// - Option to rate the app on the app store
///
/// This widget leverages shared preferences for data persistence, such as
/// checking if the app is unlocked and retrieving user account information
///
class SettingsScreen extends StatefulWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isAppUnlocked = false;
  String nickname = '';
  String birthday = '';

  @override
  void initState() {
    super.initState();
    _loadUnlockStatus();
  }

  /// Loads the app unlock status and user details from shared preferences.
  ///
  /// This method checks if the app is unlocked and loads the user's nickname
  /// and birthday. Updates the UI based on the loaded data.
  Future<void> _loadUnlockStatus() async {
    try {
      final date = await PreferencesHelper.getDate();
      final username = await PreferencesHelper.getNickname();
      _isAppUnlocked = await PreferencesHelper.getIsAppUnlocked();

      setState(() {
        if (username != null) nickname = username;
        if (date['day'] != null &&
            date['month'] != null &&
            date['year'] != null) {
          birthday = "${date['day']!}/${date['month']!}/${date['year']!}";
        }
      });
    } catch (e) {
      print("Error loading unlock status: $e");
      // Optionally, show an error message to the user or log the error
    }
  }

  /// Unlocks the app by updating the shared preferences.
  ///
  /// After unlocking, the UI is updated to hide the unlock option.
  Future<void> _unlockApp() async {
    await PreferencesHelper.setIsAppUnlocked(true);
    setState(() {
      _isAppUnlocked = true;
    });
  }

  /// Opens the app's store listing for rating.
  ///
  /// Uses the [InAppReview] package to open the app's store listing.
  Future<void> _rateApp() async {
    final inAppReview = InAppReview.instance;
    await inAppReview.openStoreListing();
  }

  /// Displays a dialog to confirm unlocking the app.
  ///
  /// Shows an [AlertDialog] with options to unlock or cancel.
  void _showUnlockDialog() {
    if (_isAppUnlocked)
      return; // Prevent  opening dialog if app is already unlocke
    showDialog(
      context: context,
      builder: (context) => _buildUnlockDialog(context),
    );
  }

  /// Builds the unlock confirmation dialog.
  ///
  /// The dialog has a title, message, and two actions for confirming
  /// or canceling the unlock operation.
  Widget _buildUnlockDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        AppLocalizations.of(context).unlockAppButton,
        style: const TextStyle(color: Colors.white),
      ),
      content: Text(
        AppLocalizations.of(context).unlockAppConfirmation,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context).no,
              style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            _unlockApp();
            context.pop();
          },
          child: Text(AppLocalizations.of(context).yes,
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).settingsButton,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                if (!_isAppUnlocked)
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).unlockAppButton,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    onTap: _showUnlockDialog,
                  ),
                if (!_isAppUnlocked) const Divider(color: Colors.grey),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context).rateUs,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  onTap: _rateApp,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Section title for account information
          Text(
            AppLocalizations.of(context).myAccount,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 10),

          // Container for displaying user nickname and birthday
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    AppLocalizations.of(context).usernameLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  trailing: Text(
                    nickname,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                ),
                const Divider(color: Colors.grey),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context).birthdayLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  trailing: Text(
                    birthday,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
