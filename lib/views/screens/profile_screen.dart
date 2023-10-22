import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).h,
      child: Column(
        children: [
          MainCard(
            child: Padding(
              padding: const EdgeInsets.all(10).h,
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60.h,
                      backgroundColor: context.colors.inversePrimary,
                      child: CircleAvatar(
                        radius: 59.h,
                        backgroundImage: const NetworkImage("https://picsum.photos/100"),
                      ),
                    ),
                  ),
                  7.5.verticalSpace,
                  Text(
                    "Ahmed Usama",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colors.inversePrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "eng.ahmedusamma@gmail.com",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colors.secondary.withOpacity(.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  7.5.verticalSpace,
                  Text(
                    "This is my contact bio, please read and guess what it is talking about.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: context.colors.secondary),
                  ),
                  7.5.verticalSpace,
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: context.colors.inversePrimary, size: 15.h),
                    label: Text("Edit", style: TextStyle(color: context.colors.inversePrimary)),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.bookmark, color: context.colors.inversePrimary),
              label: Text("Saved Messages", style: TextStyle(color: context.colors.inversePrimary)),
              style: OutlinedButton.styleFrom(backgroundColor: context.colors.primary),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Log out", style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(backgroundColor: context.colors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
