import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:chat/views/screens/chat_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactItem extends StatelessWidget {
  final String image;
  final String name;
  final String? bio;

  const ContactItem({
    super.key,
    required this.image,
    required this.name,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(const ChatScreen());
      },
      child: MainCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5).h,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.h,
              backgroundColor: context.colors.primary,
              child: CircleAvatar(
                radius: 24.h,
                backgroundImage: NetworkImage(image),
              ),
            ),
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
