import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/services/prefs_service.dart';
import 'package:chat/core/theme/theme_config.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/providers/theme_provider.dart';
import 'package:chat/views/layouts/main_layout.dart';
import 'package:chat/views/screens/auth_screen.dart';
import 'package:chat/views/screens/chat_room_screen.dart';
import 'package:chat/views/screens/profile_public_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = useState<UserModel?>(null);

    void getData(WidgetRef ref, User data) async {
      userModel.value = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
      ref.read(userProvider.notifier).update((state) => userModel.value);
    }

    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            themeMode: ref.watch(themeProvider.select((provider) => provider.currentTheme)),
            theme: ThemeConfig.light,
            darkTheme: ThemeConfig.dark,
            home: ref.watch(authChangeProvider).when(
                  data: (data) {
                    if (data != null) {
                      getData(ref, data);
                      return const MainLayout();
                    }
                    return const AuthScreen();
                  },
                  error: (error, stackTrace) => Center(child: Text(error.toString())),
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
            onGenerateRoute: (settings) {
              return switch (settings.name) {
                "/profile" => () {
                    final userId = settings.arguments as String;
                    return MaterialPageRoute(builder: (_) => PublicProfileScreen(uid: userId));
                  }(),
                "/room" => () {
                    final roomId = settings.arguments as String;
                    return MaterialPageRoute(builder: (_) => ChatScreen(roomId: roomId));
                  }(),
                "/user-room" => () {
                    final otherId = settings.arguments as String;
                    final myId = ref.read(userProvider)!.uid;
                    return MaterialPageRoute(builder: (_) => ChatScreen(roomId: generateRoomId(myId, otherId)));
                  }(),
                _ => null,
              };
            },
          ),
        );
      },
    );
  }
}
