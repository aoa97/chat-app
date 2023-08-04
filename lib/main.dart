import 'package:chat/controllers/theme_provider.dart';
import 'package:chat/core/services/prefs_service.dart';
import 'package:chat/core/theme/theme_config.dart';
import 'package:chat/views/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(prefs: PrefsService()),
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chat',
              themeMode: context.select((ThemeProvider theme) => theme.currentTheme),
              theme: ThemeConfig.light,
              darkTheme: ThemeConfig.dark,
              home: child,
            ),
          );
        },
        child: const MainLayout(),
      ),
    );
  }
}
