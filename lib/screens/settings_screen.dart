import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                ListTile(
                  title: Text(
                    'Unlock App',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Add unlock app functionality
                  },
                ),
                Divider(color: Colors.grey),
                ListTile(
                  title: Text(
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
          SizedBox(height: 20),
          Text(
            'My Account',
            style: TextStyle(
              color: Color.fromRGBO(149, 149, 149, 1),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Username',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    'John Smith', // Replace with dynamic username
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  title: Text(
                    'Birthday',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
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
