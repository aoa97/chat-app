import 'package:chat/core/services/prefs_service.dart';
import 'package:chat/core/theme/theme_config.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/views/layouts/main_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            theme: ThemeConfig.light,
            darkTheme: ThemeConfig.dark,
            home: child,
          ),
        );
      },
      child: const MainLayout(),
    );
  }
}
