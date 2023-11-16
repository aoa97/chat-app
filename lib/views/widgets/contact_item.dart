import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:chat/views/layouts/main_card.dart';
import 'package:chat/views/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactItem extends ConsumerWidget {
  final String id;
  final String image;
  final String name;
  final String? bio;
  final VoidCallback onTap;

  const ContactItem({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.bio,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: MainCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5).h,
          child: ListTile(
            leading: MainAvatar(imageUrl: image, dimension: 45.h),
            title: Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: context.colors.primary,
              ),
            ),
            subtitle: elseNull(
              condition: bio != null,
              child: Text(
                bio ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.sp, color: context.colors.secondary),
              ),
            ),
            horizontalTitleGap: 10.w,
          ),
        ),
      ),
    );
  }
}
