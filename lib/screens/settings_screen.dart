import 'package:app_task_demo/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';

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
      title: const Text(
        'Unlock App',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        'Are you sure you want to unlock the app?',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('No', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            _unlockApp();
            context.pop();
          },
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
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
          const Text(
            'Settings',
            style: TextStyle(
              color: Color.fromRGBO(149, 149, 149, 1),
              fontSize: 16,
            ),
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
                    title: const Text(
                      'Unlock App',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: _showUnlockDialog,
                  ),
                if (!_isAppUnlocked) const Divider(color: Colors.grey),
                ListTile(
                  title: const Text(
                    'Rate Us',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: _rateApp, // Call the feedback dialog
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'My Account',
            style: TextStyle(
              color: Color.fromRGBO(149, 149, 149, 1),
              fontSize: 16,
            ),
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
                  title: const Text(
                    'Username',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    nickname,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(color: Colors.grey),
                ListTile(
                  title: const Text(
                    'Birthday',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    birthday,
                    style: const TextStyle(color: Colors.grey),
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
