import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
# Secure Storage Documentation

## Overview

This documentation provides an overview of how secure storage is implemented using the `flutter_secure_storage` package in the `PreferencesHelper` class. Secure storage is used to store sensitive data, such as user preferences, credentials, and application states, in a secure manner.

## Why Use Secure Storage?

The `flutter_secure_storage` package allows for securely storing data on the user's device. Unlike using plain text or `SharedPreferences`, which is more vulnerable to unauthorized access, secure storage encrypts the data. This is particularly important for information such as usernames, passwords, and other private information.

## How Secure Storage is Implemented

### 1. Creating an Instance of Secure Storage

A static instance of `FlutterSecureStorage` is created to facilitate data storage:
```dart
static const _secureStorage = FlutterSecureStorage();
```

This instance is used to perform read and write operations securely.

### 2. Saving and Retrieving Data

**Saving Data:**
- Methods like `saveNickname`, `setIsAppUnlocked`, and `saveDate` are used to save various pieces of data (e.g., nickname, date of birth, and app unlock status).
- Example of saving data:
  ```dart
  static Future<void> saveNickname(String nickname) async {
    await _secureStorage.write(key: nicknameKey, value: nickname);
  }
  ```
**Retrieving Data:**
- Methods like `getNickname`, `getIsAppUnlocked`, and `getDate` are used to retrieve saved data securely.
- Example of retrieving data:
  ```dart
  static Future<String?> getNickname() async {
    return await _secureStorage.read(key: nicknameKey);
  }
  ```

### 3. Managing Sensitive Information

- **Nickname**: Saved and retrieved using secure storage methods to protect the user's nickname.
- **App Unlock Status**: The status of whether the app is unlocked is stored as a boolean (`true` or `false`) but saved as a string to secure storage.
- **Date Information**: Day, month, and year are saved individually to allow for flexibility in data usage, and each value is encrypted before being stored.

## Usage Example

Here is an example of how to use the `PreferencesHelper` class to store and retrieve a user's nickname:

```dart
await PreferencesHelper.saveNickname('JohnDoe');
String?
*/
class PreferencesHelper {
  static const String nicknameKey = 'nickname';
  static const String dayKey = 'day';
  static const String monthKey = 'month';
  static const String yearKey = 'year';
  static const String isAppUnlockedKey = 'isAppUnlocked';

  // Create a secure storage instance
  static const _secureStorage = FlutterSecureStorage();

  // Save nickname
  static Future<void> saveNickname(String nickname) async {
    await _secureStorage.write(key: nicknameKey, value: nickname);
  }

  // Get nickname
  static Future<String?> getNickname() async {
    return await _secureStorage.read(key: nicknameKey);
  }

  // Set app unlock status
  static Future<void> setIsAppUnlocked(bool isUnlocked) async {
    await _secureStorage.write(
        key: isAppUnlockedKey, value: isUnlocked.toString());
  }

  // Get app unlock status
  static Future<bool> getIsAppUnlocked() async {
    String? value = await _secureStorage.read(key: isAppUnlockedKey);
    return value == 'true';
  }

  // Save date (day, month, year)
  static Future<void> saveDate(String day, String month, String year) async {
    await _secureStorage.write(key: dayKey, value: day);
    await _secureStorage.write(key: monthKey, value: month);
    await _secureStorage.write(key: yearKey, value: year);
  }

  // Get date
  static Future<Map<String, String?>> getDate() async {
    return {
      'day': await _secureStorage.read(key: dayKey),
      'month': await _secureStorage.read(key: monthKey),
      'year': await _secureStorage.read(key: yearKey),
    };
  }
}
