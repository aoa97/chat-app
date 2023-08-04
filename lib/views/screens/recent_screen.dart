import 'package:chat/utils/extensions.dart';
import 'package:chat/views/containers/main_wrapper.dart';
import 'package:chat/views/containers/recent_list.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainWrapper(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search by name",
              prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ),
          ),
        ),
        30.sph,
        const Expanded(
          child: RecentList(),
        ),
      ],
    );
  }
}
