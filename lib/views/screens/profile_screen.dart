import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/layouts/main_card.dart';
import 'package:chat/views/screens/profile_edit_screen.dart';
import 'package:chat/views/widgets/main_button.dart';
import 'package:chat/views/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10).h,
      child: Column(
        children: [
          MainCard(
            child: Padding(
              padding: const EdgeInsets.all(10).h,
              child: ref.watch(getUserDataProvider(user!.uid)).when(
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                    data: (user) => Column(
                      children: [
                        Center(
                          child: MainAvatar(
                            imageUrl: user.avatar ?? "",
                            dimension: 100.h,
                            strokeWidth: 2,
                          ),
                        ),
                        7.5.verticalSpace,
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: context.colors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colors.secondary.withOpacity(.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (user.bio != null) ...[
                          7.5.verticalSpace,
                          Text(
                            user.bio!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14.sp, color: context.colors.secondary),
                          ),
                        ],
                        7.5.verticalSpace,
                        MainButton(
                          type: MainButtonType.outlined,
                          icon: Icon(Icons.edit, color: context.colors.primary, size: 15.h),
                          child: Text(Constants.edit, style: TextStyle(color: context.colors.primary)),
                          onPressed: () => context.push(const EditProfileScreen()),
                        ),
                      ],
                    ),
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
          MainButton(
            expanded: true,
            type: MainButtonType.outlined,
            onPressed: ref.read(authControllerProvider.notifier).logOut,
            icon: const Icon(Icons.logout, color: Colors.red),
            child: const Text(Constants.logOut, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
