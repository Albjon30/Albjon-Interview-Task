import 'package:app_task_demo/shared/constants/fonts/fonts.dart';
import 'package:flutter/material.dart';

const Color lightOnSurface = Color(0xffffffff);
const Color darkOnSurface = Color(0xFF1B1B1F);

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  ThemeMode getTheme() {
    return ThemeMode.light;
  }

  static ThemeData get lightTheme => ThemeData(
        fontFamily: 'Lato',
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF275CB1),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFD8E2FF),
          onPrimaryContainer: Color(0xFF001A42),
          secondary: Color(0xFF575E71),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFDBE2F9),
          onSecondaryContainer: Color(0xFF141B2C),
          tertiary: Colors.purple,
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFE8DDFF),
          onTertiaryContainer: Color(0xFF21005E),
          error: Color(0xFFBA1A1A),
          onError: Color(0xFFFFFFFF),
          errorContainer: Color(0xFFFFDAD6),
          onErrorContainer: Color(0xFF410002),
          outline: Color(0xFF75777F),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF1B1B1F),
          onSurfaceVariant: Color(0xFF44474F),
          inverseSurface: Color(0xFF303034),
          onInverseSurface: Color(0xFFF2F0F4),
          inversePrimary: Color(0xFFADC6FF),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF275CB1),
          outlineVariant: Color(0xFFC4C6D0),
          scrim: Color(0xFF000000),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF6750A4),
        ),
        textTheme: TextTheme(
          displayLarge: displayLarge.apply(color: lightOnSurface),
          displayMedium: displayMedium.apply(color: lightOnSurface),
          titleMedium: titleMedium.apply(color: lightOnSurface),
          titleSmall: titleSmall.apply(color: lightOnSurface),
          labelMedium: labelMedium.apply(color: lightOnSurface),
          bodyMedium: bodyMedium.apply(color: lightOnSurface),
          bodySmall: bodySmall.apply(color: lightOnSurface),
          labelLarge: labelLarge.apply(color: lightOnSurface),
          labelSmall: labelSmall.apply(color: lightOnSurface),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );

  static ThemeData get darkTheme => ThemeData(
        fontFamily: 'Nunito',
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFADC6FF),
          onPrimary: Color(0xFF002E6A),
          primaryContainer: Color(0xFF004395),
          onPrimaryContainer: Color(0xFFD8E2FF),
          secondary: Color(0xFFBFC6DC),
          onSecondary: Color(0xFF293041),
          secondaryContainer: Color(0xFF3F4759),
          onSecondaryContainer: Color(0xFFDBE2F9),
          tertiary: Color(0xFFCEBDFF),
          onTertiary: Colors.purple,
          tertiaryContainer: Color(0xFF4D388B),
          onTertiaryContainer: Color(0xFFE8DDFF),
          error: Color(0xFFFFB4AB),
          onError: Color(0xFF690005),
          errorContainer: Color(0xFF93000A),
          onErrorContainer: Color(0xFFFFDAD6),
          outline: Color(0xFF8E9099),
          surface: Color(0xFF121316),
          onSurface: Color(0xFFC7C6CA),
          onSurfaceVariant: Color(0xFFC4C6D0),
          inverseSurface: Color(0xFFE3E2E6),
          onInverseSurface: Color(0xFF1B1B1F),
          inversePrimary: Color(0xFF275CB1),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFFADC6FF),
          outlineVariant: Color(0xFF44474F),
          scrim: Color(0xFF000000),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFD0BCFF),
        ),
        textTheme: TextTheme(
          displayLarge: displayLarge.apply(color: darkOnSurface),
          displayMedium: displayMedium.apply(color: darkOnSurface),
          titleMedium: titleMedium.apply(color: darkOnSurface),
          titleSmall: titleSmall.apply(color: darkOnSurface),
          labelMedium: labelMedium.apply(color: darkOnSurface),
          bodyMedium: bodyMedium.apply(color: darkOnSurface),
          bodySmall: bodySmall.apply(color: darkOnSurface),
          labelLarge: labelLarge.apply(color: darkOnSurface),
          labelSmall: labelSmall.apply(color: darkOnSurface),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );
}
