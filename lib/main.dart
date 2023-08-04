import 'package:chat/utils/assets.dart';
import 'package:chat/views/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            themeMode: ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: Fonts.roboto,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                primary: Colors.white,
                inversePrimary: Colors.black,
                secondary: Colors.grey,
                background: Colors.grey[200],
                surface: Colors.grey[200],
                onSurface: Colors.black,
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onBackground,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
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
                fillColor: const Color.fromARGB(255, 27, 27, 27),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            ),
            home: child,
          ),
        );
      },
      child: const MainLayout(),
    );
  }
}
