import 'package:chat/utils/extensions.dart';
import 'package:chat/views/widgets/main_wrapper.dart';
import 'package:chat/views/widgets/recent_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            itemBuilder: (c, i) => const RecentItem(
              image: "https://picsum.photos/50",
              user: "Adam",
              message: "This is a long message created by messsssssssssssssssssssssssssssss",
              createdAt: "3AM",
            ),
            separatorBuilder: (c, i) => 15.h.sph,
            padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
          ),
        ),
      ],
    );
  }
}
