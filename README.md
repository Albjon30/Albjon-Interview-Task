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
   if (_isAppUnlocked) return; /// Prevent opening dialog if app is already unlocked

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

Firebase Analytics and Crashlytics Integration 

Implementation

### Firebase Initialization
Firebase is initialized in the main.dart file using Firebase.initializeApp(), ensuring that Analytics and Crashlytics services are available globally across the app.
The Firebase initialization sequence is placed before any Firebase-dependent services to prevent potential runtime issues.


Firebase Analytics automatically logs basic app events like screen views, app opens, and user sessions.
Custom events are logged to track specific actions relevant to app engagement metrics (e.g., button clicks, feature usage).


### Firebase Crashlytics
Crashlytics captures uncaught errors and logs them, providing stack traces and device information to help diagnose issues.
Flutter errors are caught using FlutterError.onError, and uncaught asynchronous errors are captured via PlatformDispatcher.instance.onError.

    Example setup in main.dart:

        try {
      await MobileAds.instance.initialize();
         } catch (e, stackTrace) {
             FirebaseCrashlytics.instance.recordError(e, stackTrace,
             reason: 'Failed to initialize Google Mobile Ads:');
    
             adsInitialized = false;
       }


### Testing and Validation

### code to simulate crash
- FirebaseCrashlytics.instance.crash();
 
Crashlytics Testing: Crashlytics functionality was validated by forcing test crashes during 
  development

-Notes
Error Handling: Crashlytics is configured to handle fatal and non-fatal errors,
providing comprehensive crash reporting.



#### ############### ################### ############ ############# ###

### Memory usage
Memory Usage Optimization:
1. Avoided Memory Leaks: I tried properly to dispose of controllers like TextEditingController, AnimationController, and other listeners to avoid memory leaks.
2. Lazy Loading: Implemented lazy loading for resources such as images and data, loading them only when necessary, which prevents high memory consumption from objects that are not immediately needed.
3. Efficient Data Structures: Replaced less efficient data structures with more memory-friendly alternatives
    (e.g., List instead of LinkedList when random access is prioritized).
-Memory leaks are one of the leading causes of app crashes. By ensuring controllers are properly disposed of and objects are not held unnecessarily,

### CPU usage

1. Optimized sorting, looping algorithms to ensure they run in optimal time complexity, avohiding nested loops where possible.
2. Reduced Re-renders: Utilized tools like Bloc or Provider to minimize unnecessary widget rebuilds, thereby decreasing the CPU load during UI updates.
   (In our case, I didn’t do that since it's a test demo app, and I u sed setState. I didn’t want to use anything else because of the complexity.
   For the final version or a more performance-intensive app, switching to Bloc or Provider,riverpod it would certainly be beneficial for optimizing those CPU resources further.)
   "I prefer BLoC"


### Battery usage
1. Minimized Background Processes: Rceduced background tasks to only those necessary for the application, ensuring the app is not consuming power unnecessarily.
2. Efficient Animations: Used efficient, lightweight animations with reduced frame rates and avoided constant, power-hungry animations.
3. Background Fetch Frequency: Limited background API calls to minimize power consumption when the app isn’t actively 
   in use. In our case, data is  retrieved through SecureStorage, 
   reducing unnecessary background operations.

### Network usage

1. Data Compression: Implemented data compression techniques when transferring data over the network to minimize the amount of data sent and received.
2. Caching Responses: Cached API responses locally to avoid redundant network calls, especially for data that does not change frequently.
4. Network requests can be costly, both in terms of data usage and power consumption. By
   compressing data, caching frequently used responses,
   and batching API requests, we can reduce network overhead and improve the app's overall responsiveness, especially on slower networks.

### Do you believe you can make a bug free app? If so, what would you need? If not, justify

When it comes to making a bug- free app, I believe that creating an application  completely free of bugs is nearly impossible
. Software Apps are very complex, and different users interact with it in unpredictable ways, leading to cases that can be difficult to anticipate.
However, it's possible to significantly reduce bugs and create a highly stable app by 
employing best practices such as thorough testing,  code reviews, and effective quality assurance processes.
Techniques like writing extensive unit tests, integration tests, UI tests, and ensuring a robust feedback loop for user-reported 
issues can help minimize the occurrence of bugs. Additionally, adhering to good software design principles, having a clear
understanding of requirements, and employing effective state management are crucial for building a stable application.
In summary, while it's challenging to guarantee a bug-free application, focusing on rigorous testing, proactive issue management, 
and following best practices can result in an app that is highly reliable and meets user expectations effectively.

Based on my experience, here are some practices I’ve implemented:
   - Achieved 70% test coverage by writing thorough unit and widget tests to ensure code reliability, catch regressions, and maintain functionality over time.
   - Leveraged BloC for state management to create a scalable and maintainable architecture. This approach keeps
      the UI separate from business logic, enhancing testability and supporting a clean, organized codebase.
   

### Some Extra Performance Considerations that are needed for optimal efficiency

- Control [build()] method since it can be invoked frequently when ancestor widgets rebuild
- localize [setState()] avoid calling it high up in the tree if changes are in a small part
- Using Opacity with animation can be resource-intensive since it requires the widget to be rendered 
   even when not visible. Alternatives such as AnimatedOpacity or FadeTransition(we use it in go_route)
