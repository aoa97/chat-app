import 'package:chat/core/providers/theme_provider.dart';
import 'package:chat/core/routing/route_generator.dart';
import 'package:chat/core/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            themeMode: ref.watch(themeProvider.select((p) => p.currentTheme)),
            theme: ThemeConfig.light,
            darkTheme: ThemeConfig.dark,
            onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings, ref),
          ),
        );
      },
    );
  }
}
