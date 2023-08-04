import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/widgets/recent_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentList extends HookWidget {
  const RecentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (c, i) => const RecentItem(
        image: "https://picsum.photos/50",
        user: "Adam",
        message: "This is a long message created by messsssssssssssssssssssssssssssss",
        createdAt: "3AM",
      ),
      separatorBuilder: (c, i) => 15.h.sph,
      padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
    );
  }
}
