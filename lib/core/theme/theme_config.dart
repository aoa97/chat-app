import 'package:chat/core/utils/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeConfig {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: Fonts.roboto,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.white,
        inversePrimary: Colors.black,
        secondary: Colors.grey,
        background: const Color(0xFFeeeeee),
        surface: Colors.grey[200],
        onSurface: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.yellow,
        primary: const Color.fromARGB(255, 27, 27, 27),
        inversePrimary: Colors.white,
        secondary: Colors.grey,
        surface: const Color.fromARGB(255, 27, 27, 27),
        onSurface: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color.fromARGB(255, 37, 36, 36),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12.sp, fontWeight: FontWeight.w400),
      ),
    );
  }
}
