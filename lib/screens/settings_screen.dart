import 'package:app_task_demo/shared_preferences/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
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

  Future<void> _loadUnlockStatus() async {
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
    setState(() {
      _isAppUnlocked = _isAppUnlocked;
    });
  }

  Future<void> _unlockApp() async {
    await PreferencesHelper.setIsAppUnlocked(true);
    setState(() {
      _isAppUnlocked = true;
    });
  }

  Future<void> _rateApp() async {
    final inAppReview = InAppReview.instance;
    await inAppReview.openStoreListing();
  }

  void _showUnlockDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildUnlockDialog(context),
    );
  }

  Widget _buildUnlockDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        AppLocalizations.of(context).unlockAppButton,
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        AppLocalizations.of(context).unlockAppConfirmation,
        style: TextStyle(color: Colors.white),
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
                  onTap: _rateApp, // Call the feedback dialog
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context).myAccount,
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
