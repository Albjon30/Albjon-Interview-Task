# app_task_demo

apply-at-supono

Albjon-Interview-Task 

1. Date Picker 
The Date Picker dialog has been customized to match the application's overall theme and 
provide a better user experience. The new feature added to customize the Date Picker dialog
significantly enhances the application's aesthetics and user experience.

2. Form Validation

Validation has been added to various input fields to ensure users enter valid and meaningful information.
This includes validating the date input fields for the user's birthdate,
such as day, month, and year, to prevent invalid or impossible dates.

#### Additional Requests ###

----------Separation of Styling Constants-------
I separated common styling properties, such as font sizes, colors, padding,
and decorations, into reusable constants.
For instance, text styles like displayLarge, titleMedium, and labelSmall
were defined in a styles.dart file. This approach redduces code redundancy and allows for easy modification
of styles globally from one location.

ThemeData Customization: Leveraging Flutter’s ThemeData, I defined global theme properties for text styles,
button styles, and color schemes. This ensures that the app maintains a consistent look and feel
across all screens and that any style updates reflect universally.


---------------Security---------------------
###### Why I Use Secure Storage  ######

In Our app since we doesn't have implemented yet any auth logic

The `flutter_secure_storage` package allows for securely storing data on the user's device.
Unlike using plain text or `SharedPreferences`, which is more vulnerable to unauthorized access,
secure storage encrypts the data. This is particularly important for information   such as usernames,
passwords, and other private information.

By using `flutter_secure_storage`, sensitive data such as user nicknames, date of birth,
and app unlock stastus are stored securely, making it difficult for unauthorized users to gain 
access to this information, even if they have physical access to the device. 
This added layer of security is crucial for protecting user data, enhancing privacy,
and ensuring that no sensitive information is exposed.

Another method that We can use is:
Obfuscate and Minify Code:
Enable code obfuscation in Flutter to make it harder for attackers to reverse-engineer your code.
We can add --obfuscate --split-debug-info in your build configurations.
This is especially important when publishing to the Google Play Store.

----------- Error Handling -------------
###### Explanation ######

Here some of the Error Handling that I implemented

1. Handle Initialization Errors for Google Mobile Ads
Wrap the Google Mobile Ads initialization in a try-catch block to handle potential errors gracefully
If initialization fails, we can log the error or display a message to the user.
2. Error Handling in Banner Ad Loading
For ad loading,I improved error handling by showing an error message or
retrying after a delay if the ad fails to load.
3. Error Handling in Asynchronous Functions
Wrap asynchronous functions in try-catch blocks to catch and handle errors when
retrieving or updating data, such as with SecureStorage or SharedPreferences.
4. Handle User Actions Gracefully
If users try to interact with the app while ads are loading or network operations are underway,
show a loading indicator or disable buttons temporarily.

Exp.
void _showUnlockDialog() {
   if (_isAppUnlocked) return; // Prevent opening dialog if app is already unlocked

   showDialog(
         context: context,
         builder: (context) => _buildUnlockDialog(context),
         );
}

1. Logging and Analytics
Logging and error tracking (e.g, using Firebase Crashlytics or Sentry) to monitor errors in production.
This way, we can capture detailed reports on issues that users experience, which helps improve app stability.
In Our app I will implement Firebase Crashlytics


--------------- Crashlytics & Analytics ---------

Firebase Analytics and Crashlytics Integration Documentation
Overview

This project integrates Firebase Analytics and Firebase Crashlytics to monitor app usage, track user engagement, and handle error reporting effectively. Firebase Analytics provides insights into user behavior, while Crashlytics helps detect, diagnose, and resolve app crashes.
Purpose

    Firebase Analytics: To gain insights into user engagement, app performance, and user retention by tracking user events and custom metrics.
    Firebase Crashlytics: To monitor app stability by tracking crashes and exceptions, providing real-time crash reports, and helping identify issues affecting the app experience.

Implementation

    Firebase Initialization
        Firebase is initialized in the main.dart file using Firebase.initializeApp(), ensuring that Analytics and Crashlytics services are available globally across the app.
        The Firebase initialization sequence is placed before any Firebase-dependent services to prevent potential runtime issues.

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(MyApp());
}

Firebase Analytics
Firebase Analytics automatically logs basic app events like screen views, app opens, and user sessions.
Custom events are logged to track specific actions relevant to app engagement metrics (e.g., button clicks, feature usage).

Analytics logging example:

    import 'package:firebase_analytics/firebase_analytics.dart';

    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    void logCustomEvent() {
      analytics.logEvent(
        name: "custom_event_name",
        parameters: {"key": "value"},
      );
    }

Firebase Crashlytics
Crashlytics captures uncaught errors and logs them, providing stack traces and device information to help diagnose issues.
Flutter errors are caught using FlutterError.onError, and uncaught asynchronous errors are captured via PlatformDispatcher.instance.onError.

    Example setup in main.dart:

        import 'package:firebase_crashlytics/firebase_crashlytics.dart';

        void main() {
          FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
          PlatformDispatcher.instance.onError = (error, stack) {
            FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
            return true;
          };
        }

Testing and Validation

    Analytics Testing: Test events were logged in debug mode and validated in the Firebase Console to ensure data accuracy and event tracking functionality.
    Crashlytics Testing: Crashlytics functionality was validated by forcing test crashes during development. Test data was reviewed in the Firebase Console for completeness and accuracy.

Notes

    Data Privacy: Firebase Analytics and Crashlytics respect user privacy settings, and users are informed of data collection in compliance with data privacy laws.
    Error Handling: Crashlytics is configured to handle fatal and non-fatal errors, providing comprehensive crash reporting.