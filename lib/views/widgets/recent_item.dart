import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/layouts/main_card.dart';
import 'package:chat/views/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentItem extends StatelessWidget {
  final String image;
  final String user;
  final String message;
  final String? createdAt;
  final VoidCallback onTap;

  const RecentItem({
    super.key,
    required this.image,
    required this.user,
    required this.message,
    required this.createdAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MainCard(
        child: ListTile(
          leading: MainAvatar(imageUrl: image, dimension: 40.h),
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
          trailing: createdAt != null
              ? Padding(
                  padding: const EdgeInsets.all(5).h,
                  child: Text(
                    createdAt!,
                    style: TextStyle(color: context.colors.primary, fontSize: 10.sp),
                  ),
                )
              : null,
          dense: true,
          horizontalTitleGap: 7.5.w,
          titleAlignment: ListTileTitleAlignment.top,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        ),
      ),
    );
  }
}
