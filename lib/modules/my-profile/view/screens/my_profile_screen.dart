import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/widgets/main_button.dart';
import 'package:chat/core/widgets/main_card.dart';
import 'package:chat/modules/auth/controller/auth_controller.dart';
import 'package:chat/modules/my-profile/view/containers/my_profile_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

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
                  const MyProfileDetails(),
                  7.5.verticalSpace,
                  MainButton(
                    type: MainButtonType.outlined,
                    icon: Icon(Icons.edit, color: context.colors.primary, size: 15.h),
                    child: Text(Constants.edit, style: TextStyle(color: context.colors.primary)),
                    onPressed: () => context.pushNamed("/edit-profile"),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // MainButton(
          //   expanded: true,
          //   type: MainButtonType.outlined,
          //   onPressed: () {},
          //   icon: Icon(Icons.bookmark, color: context.colors.primary),
          //   child: Text(Constants.savedMessages, style: TextStyle(color: context.colors.primary)),
          // ),
          Consumer(
            builder: (context, ref, child) => MainButton(
              expanded: true,
              type: MainButtonType.outlined,
              onPressed: ref.read(authControllerProvider.notifier).logOut,
              icon: const Icon(Icons.logout, color: Colors.red),
              child: const Text(Constants.logOut, style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
