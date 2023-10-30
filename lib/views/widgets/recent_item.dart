import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentItem extends StatelessWidget {
  final String image;
  final String user;
  final String message;
  final String createdAt;

  const RecentItem({
    super.key,
    required this.image,
    required this.user,
    required this.message,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.push(const ChatScreen());
      },
      child: MainCard(
        child: ListTile(
          leading: CircleAvatar(
            radius: 20.h,
            backgroundColor: context.colors.inversePrimary,
            child: CircleAvatar(
              radius: 19.h,
              backgroundImage: NetworkImage(image),
            ),
          ),
          title: Text(
            user,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: context.colors.primary,
            ),
          ),
          subtitle: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10.sp, color: context.colors.secondary),
          ),
          trailing: Text(
            createdAt,
            style: TextStyle(color: context.colors.inversePrimary, fontSize: 10.sp),
          ),
          dense: true,
          horizontalTitleGap: 7.5.w,
          titleAlignment: ListTileTitleAlignment.top,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        ),
      ),
    );
  }
}
