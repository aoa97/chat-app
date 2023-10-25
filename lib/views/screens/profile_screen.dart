import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/flutter_assets.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:chat/views/screens/profile_edit_screen.dart';
import 'package:chat/views/widgets/main_button.dart';
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
                          child: Container(
                            width: 100.h,
                            height: 100.h,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              user.avatar ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Assets.userAvatarPlacehoder,
                            ),
                          ),
                        ),
                        7.5.verticalSpace,
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: context.colors.inversePrimary,
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
                          icon: Icon(Icons.edit, color: context.colors.inversePrimary, size: 15.h),
                          child: Text("Edit", style: TextStyle(color: context.colors.inversePrimary)),
                          onPressed: () => context.push(const EditProfileScreen()),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
          const Spacer(),
          MainButton(
            expanded: true,
            type: MainButtonType.outlined,
            onPressed: () {},
            icon: Icon(Icons.bookmark, color: context.colors.inversePrimary),
            child: Text("Saved Messages", style: TextStyle(color: context.colors.inversePrimary)),
          ),
          MainButton(
            expanded: true,
            type: MainButtonType.outlined,
            onPressed: ref.read(authControllerProvider.notifier).logOut,
            icon: const Icon(Icons.logout, color: Colors.red),
            child: const Text("Log out", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
