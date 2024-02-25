import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData darkThem = ThemeData(
      useMaterial3: true,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontFamily: "ROBM",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        headlineMedium: TextStyle(
            fontFamily: "ROBM",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        bodySmall: TextStyle(
          fontFamily: "ROBM",
          fontSize: 11,
          fontWeight: FontWeight.w300,
          color: Color(0xff8E8E8E),
        ),
        labelSmall: TextStyle(
          fontFamily: "ROBR",
          fontSize: 11,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titleTextStyle: const TextStyle(
            fontFamily: "ROBR",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
            color: Color(0xffF4F4F4)),
        subtitleTextStyle: const TextStyle(
            fontFamily: "ROBR",
            fontSize: 12,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
            color: Color(0xff8E8E8E)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff121212),
        titleTextStyle: TextStyle(
            fontFamily: "ROBR",
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color(0xffF4F4F4)),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        textStyle: TextStyle(
          fontFamily: "ROBR",
          fontSize: 11,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      sliderTheme: const SliderThemeData(
        thumbColor: Color(0xFF4758AC),
        activeTrackColor: Color(0xFF2748EE),
        secondaryActiveTrackColor: Color.fromARGB(255, 142, 142, 142),
        valueIndicatorTextStyle: TextStyle(
          fontFamily: "ROBR",
          fontSize: 13,
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(
            255,
            244,
            244,
            244,
          ),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xff121212),
      focusColor: Color(int.parse("ffAA00FF", radix: 16)).withOpacity(0.15),
      cardColor: const Color.fromARGB(39, 244, 244, 244),
      primaryColor: const Color(0xFF2748EE),
      colorScheme: darkColorScheme);

  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontFamily: "ROBM",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black),
        headlineMedium: TextStyle(
            fontFamily: "ROBM",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        bodySmall: TextStyle(
            fontFamily: "ROBM",
            fontSize: 11,
            fontWeight: FontWeight.w300,
            color: Color(0xff8E8E8E)),
        labelSmall: TextStyle(
          fontFamily: "ROBR",
          fontSize: 11,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titleTextStyle: const TextStyle(
            fontFamily: "ROBR",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
            color: Color(0xff000000)),
        subtitleTextStyle: const TextStyle(
            fontFamily: "ROBR",
            fontSize: 12,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
            color: Color(0xff8E8E8E)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffF4F4F4),
        titleTextStyle: TextStyle(
            fontFamily: "ROBR",
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color(0xff000000)),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        textStyle: TextStyle(
          fontFamily: "ROBR",
          fontSize: 11,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
      sliderTheme: const SliderThemeData(
        thumbColor: Color(0xFF4758AC),
        activeTrackColor: Color(0xFF2748EE),
        secondaryActiveTrackColor: Color.fromARGB(255, 142, 142, 142),
        valueIndicatorTextStyle: TextStyle(
          fontFamily: "ROBR",
          fontSize: 13,
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(
            255,
            244,
            244,
            244,
          ),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xffF4F4F4),
      focusColor: Color(int.parse("ffAA00FF", radix: 16)).withOpacity(0.2),
      cardColor: const Color.fromARGB(128, 0, 0, 0),
      primaryColor: const Color(0xFF2748EE),
      colorScheme: lightColorScheme);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF2748EE),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDEE0FF),
  onPrimaryContainer: Color(0xFF000F5C),
  secondary: Color(0xFF3A52CB),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDEE0FF),
  onSecondaryContainer: Color(0xFF00115A),
  tertiary: Color(0xFF4758AC),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDEE1FF),
  onTertiaryContainer: Color(0xFF001258),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF1B1B1F),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE3E1EC),
  onSurfaceVariant: Color(0xFF46464F),
  outline: Color(0xFF767680),
  onInverseSurface: Color(0xFFF3F0F4),
  inverseSurface: Color(0xFF303034),
  inversePrimary: Color(0xFFBBC3FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2748EE),
  outlineVariant: Color(0xFFC7C5D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFBBC3FF),
  onPrimary: Color(0xFF001E92),
  primaryContainer: Color(0xFF002DCC),
  onPrimaryContainer: Color(0xFFDEE0FF),
  secondary: Color(0xFFBAC3FF),
  onSecondary: Color(0xFF00208E),
  secondaryContainer: Color(0xFF1B37B3),
  onSecondaryContainer: Color(0xFFDEE0FF),
  tertiary: Color(0xFFB9C3FF),
  onTertiary: Color(0xFF12277B),
  tertiaryContainer: Color(0xFF2D3F93),
  onTertiaryContainer: Color(0xFFDEE1FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1B1B1F),
  onBackground: Color(0xFFE4E1E6),
  surface: Color(0xFF1B1B1F),
  onSurface: Color(0xFFE4E1E6),
  surfaceVariant: Color(0xFF46464F),
  onSurfaceVariant: Color(0xFFC7C5D0),
  outline: Color(0xFF90909A),
  onInverseSurface: Color(0xFF1B1B1F),
  inverseSurface: Color(0xFFE4E1E6),
  inversePrimary: Color(0xFF2748EE),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFBBC3FF),
  outlineVariant: Color(0xFF46464F),
  scrim: Color(0xFF000000),
);
