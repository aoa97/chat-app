import 'package:chat/utils/assets.dart';
import 'package:chat/utils/extensions.dart';
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
      (icon: const Icon(Icons.schedule), label: "Recent", screen: const RecentScreen()),
      (icon: const Icon(Icons.people), label: "Contacts", screen: const Text("Contacts Screen")),
      (icon: const Icon(Icons.person), label: "Profile", screen: const Text("Profile Screen")),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screens[currentIndex.value].label.toUpperCase(),
          style: const TextStyle(fontFamily: Fonts.bungee),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (i) => currentIndex.value = i,
        selectedItemColor: context.colors.inversePrimary,
        unselectedItemColor: context.colors.secondary,
        items: [...screens.map((e) => BottomNavigationBarItem(label: e.label, icon: e.icon))],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
        child: screens[currentIndex.value].screen,
      ),
    );
  }
}
