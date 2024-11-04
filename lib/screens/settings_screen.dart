import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isAppUnlocked = false;

  @override
  void initState() {
    super.initState();
    _loadUnlockStatus();
  }

  Future<void> _loadUnlockStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAppUnlocked = prefs.getBool('isAppUnlocked') ?? false;
    });
  }

  Future<void> _unlockApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAppUnlocked', true);
    setState(() {
      _isAppUnlocked = true;
    });
  }

  void _showUnlockDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Unlock App'),
          content: const Text('Are you sure you want to unlock the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _unlockApp(); // Unlock the app
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
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
                  onTap: () {
                    // Add rate us functionality
                  },
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
                  trailing: const Text(
                    'John Smith', // Replace with dynamic username
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(color: Colors.grey),
                ListTile(
                  title: const Text(
                    'Birthday',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Text(
                    '10 Feb 1989', // Replace with dynamic birthday
                    style: TextStyle(color: Colors.grey),
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
