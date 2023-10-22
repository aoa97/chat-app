import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/screens/contacts_screen.dart';
import 'package:chat/views/screens/profile_screen.dart';
import 'package:chat/views/screens/recent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayout extends HookWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (i) => currentIndex.value = i,
        selectedItemColor: context.colors.inversePrimary,
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
