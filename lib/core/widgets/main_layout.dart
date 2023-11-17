import 'package:chat/core/providers/theme_provider.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/flutter_assets.dart';
import 'package:chat/modules/contacts/view/screens/contacts_screen.dart';
import 'package:chat/modules/my-profile/view/screens/my_profile_screen.dart';
import 'package:chat/modules/recent/view/screens/recent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainLayout extends HookConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState<int>(0);

    final screens = [
      (icon: const Icon(Icons.schedule), label: Constants.recent, screen: const RecentScreen()),
      (icon: const Icon(Icons.people), label: Constants.contacts, screen: const ContactsScreen()),
      (icon: const Icon(Icons.person), label: Constants.profile, screen: const ProfileScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screens[currentIndex.value].label.toUpperCase(),
          style: const TextStyle(fontFamily: Fonts.bungee),
        ),
        actions: [
          IconButton(
            onPressed: ref.read(themeProvider.notifier).switchTheme,
            icon: ref.watch(themeProvider).isDark ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (i) => currentIndex.value = i,
        selectedItemColor: context.colors.primary,
        unselectedItemColor: context.colors.secondary,
        elevation: 0,
        items: [...screens.map((e) => BottomNavigationBarItem(label: e.label, icon: e.icon))],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
        child: screens[currentIndex.value].screen,
      ),
    );
  }
}
