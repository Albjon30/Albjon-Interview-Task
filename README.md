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


------Security-----
###### Why Use Secure Storage?  ######

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