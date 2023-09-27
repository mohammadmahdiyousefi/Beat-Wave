import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class MyThemes {
//   int customcolor;

//   MyThemes(this.customcolor);

//   static final darkTheme = ThemeData(
//     // scrollbarTheme: ScrollbarThemeData(thumbColor:),

//     sliderTheme: const SliderThemeData(
//         thumbColor: Color(0xff2962FF),
//         inactiveTrackColor: Color(0xff2962FF),
//         secondaryActiveTrackColor: Color.fromARGB(84, 41, 98, 255),
//         overlayColor: Color.fromARGB(255, 54, 54, 54),
//         valueIndicatorTextStyle: TextStyle(color: Colors.white)),
//     textTheme: TextTheme(
//       displayLarge: GoogleFonts.roboto(
//         color: Colors.white,
//         fontSize: 30,
//       ),
//       displaySmall: GoogleFonts.roboto(
//         color: Colors.grey,
//         fontWeight: FontWeight.bold,
//         fontSize: 12,
//       ),
//       displayMedium: GoogleFonts.roboto(
//         color: Colors.white,
//         fontSize: 16,
//       ),
//       titleLarge: GoogleFonts.roboto(
//           color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
//       titleMedium: GoogleFonts.roboto(
//         color: Colors.white,
//         fontSize: 13,
//       ),
//       titleSmall: GoogleFonts.roboto(
//         color: Colors.white70,
//         fontSize: 10,
//       ),
//       labelSmall: GoogleFonts.roboto(
//           color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),
//       labelMedium: GoogleFonts.roboto(
//           color: const Color.fromARGB(255, 121, 121, 121),
//           fontSize: 16,
//           fontWeight: FontWeight.w400),
//     ),

//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color.fromARGB(255, 2, 96, 247),
//     ),

//     unselectedWidgetColor: Colors.white70,
//     primaryColorLight: const Color(0xff212121),
//     scaffoldBackgroundColor: const Color(0xff121212),
//     cardColor: const Color(0xff212121),
//     primaryColor: Color(customcolor),

//     secondaryHeaderColor: Colors.white,
//     iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
//     // textSelectionTheme: const TextSelectionThemeData(
//     //   cursorColor: Colors.red,
//     //   selectionColor: Colors.green,
//     //   selectionHandleColor: Colors.blue,
//     // )
//     // colorScheme: const ColorScheme.dark()
//   );

//   static final lightTheme = ThemeData(
//     sliderTheme: const SliderThemeData(
//         thumbColor: Color(0xff2962FF),
//         inactiveTrackColor: Color(0xff2962FF),
//         secondaryActiveTrackColor: Color.fromARGB(84, 41, 98, 255),
//         overlayColor: Color.fromARGB(255, 54, 54, 54),
//         valueIndicatorTextStyle: TextStyle(color: Colors.black)),
//     textTheme: TextTheme(
//       displayLarge: GoogleFonts.roboto(color: Colors.black, fontSize: 30),
//       displaySmall: GoogleFonts.roboto(
//         color: Color.fromARGB(255, 56, 56, 56),
//         fontSize: 12,
//         fontWeight: FontWeight.bold,
//       ),
//       displayMedium: GoogleFonts.roboto(
//         color: Colors.black,
//         fontSize: 16,
//       ),
//       titleLarge: GoogleFonts.roboto(
//           color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
//       titleMedium: GoogleFonts.roboto(
//         color: Colors.black,
//         fontSize: 13,
//       ),
//       titleSmall: GoogleFonts.roboto(
//         color: Colors.black54,
//         fontSize: 12,
//       ),
//       labelSmall: GoogleFonts.roboto(
//           color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
//       labelMedium: GoogleFonts.roboto(
//           color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
//     ),

//     appBarTheme: AppBarTheme(
//       backgroundColor: Color.fromARGB(255, 35, 141, 255),
//     ),
//     cardColor: Color(0xff9BA4B5),
//     primaryColorLight: Color(0xff9BA4B5),
//     scaffoldBackgroundColor: Color(0xffDDE6ED),
//     primaryColor: Color(0xff2962FF),
//     secondaryHeaderColor: Colors.black,
//     iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),

//     // colorScheme: const ColorScheme.light()
//   );
// }

class CustomTheme {
  int primaryColor;
  // سایر ویژگی‌های تم دارک و لایت

  CustomTheme({required this.primaryColor});
}

class DarkTheme extends CustomTheme {
  DarkTheme({required int primaryColor}) : super(primaryColor: primaryColor);
  ThemeData darkthem() {
    return ThemeData(
      scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          radius: const Radius.circular(10),
          thumbColor:
              MaterialStateProperty.all(Color(primaryColor).withOpacity(0.3)),
          crossAxisMargin: 6),
      sliderTheme: SliderThemeData(
          thumbColor: Color(primaryColor),
          inactiveTrackColor: Color(primaryColor),
          secondaryActiveTrackColor: Color(primaryColor).withOpacity(0.5),
          overlayColor: const Color.fromARGB(255, 54, 54, 54),
          valueIndicatorTextStyle: const TextStyle(color: Colors.white)),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.roboto(
          color: Color(primaryColor),
          fontSize: 16,
        ),
        bodySmall: GoogleFonts.roboto(
          color: Color(primaryColor),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 25,
        ),
        headlineMedium: GoogleFonts.roboto(
          color: Color(primaryColor),
          fontSize: 18,
        ),
        displayLarge: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 30,
        ),
        displaySmall: GoogleFonts.roboto(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        displayMedium: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 16,
        ),
        titleLarge: GoogleFonts.roboto(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        titleMedium: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 13,
        ),
        titleSmall: GoogleFonts.roboto(
          color: Colors.white70,
          fontSize: 10,
        ),
        labelLarge: GoogleFonts.roboto(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
        labelSmall: GoogleFonts.roboto(
            color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),
        labelMedium: GoogleFonts.roboto(
            color: const Color.fromARGB(255, 121, 121, 121),
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 2, 96, 247),
      ),

      unselectedWidgetColor: Colors.white70,
      primaryColorLight: const Color(0xff212121),
      scaffoldBackgroundColor: const Color(0xff121212),
      cardColor: const Color(0xff212121),
      primaryColor: Color(primaryColor),

      secondaryHeaderColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
      // textSelectionTheme: const TextSelectionThemeData(
      //   cursorColor: Colors.red,
      //   selectionColor: Colors.green,
      //   selectionHandleColor: Colors.blue,
      // )
      // colorScheme: const ColorScheme.dark()
    );
  }
}

class LightTheme extends CustomTheme {
  LightTheme({required int primaryColor}) : super(primaryColor: primaryColor);

  ThemeData lighttheme() {
    return ThemeData(
      scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          radius: const Radius.circular(10),
          thumbColor:
              MaterialStateProperty.all(Color(primaryColor).withOpacity(0.6)),
          crossAxisMargin: 6),
      sliderTheme: SliderThemeData(
          thumbColor: Color(primaryColor),
          inactiveTrackColor: Color(primaryColor),
          secondaryActiveTrackColor: Color(primaryColor).withOpacity(0.5),
          overlayColor: Color.fromARGB(255, 54, 54, 54),
          valueIndicatorTextStyle: TextStyle(color: Colors.black)),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 25,
        ),
        headlineMedium: GoogleFonts.roboto(
          color: Color(primaryColor),
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.roboto(
          color: Color(primaryColor),
          fontSize: 16,
        ),
        bodySmall: GoogleFonts.roboto(
          color: Color(primaryColor),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        displayLarge: GoogleFonts.roboto(color: Colors.black, fontSize: 30),
        displaySmall: GoogleFonts.roboto(
          color: Color.fromARGB(255, 56, 56, 56),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 16,
        ),
        titleLarge: GoogleFonts.roboto(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        titleMedium: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 13,
        ),
        titleSmall: GoogleFonts.roboto(
          color: Colors.black54,
          fontSize: 12,
        ),
        labelLarge: GoogleFonts.roboto(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
        labelSmall: GoogleFonts.roboto(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
        labelMedium: GoogleFonts.roboto(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 35, 141, 255),
      ),
      cardColor: Color(0xff9BA4B5),
      primaryColorLight: Color(0xff9BA4B5),
      scaffoldBackgroundColor: Color(0xffDDE6ED),
      primaryColor: Color(primaryColor),
      secondaryHeaderColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),

      // colorScheme: const ColorScheme.light()
    );
  }
}
