import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/widgets/main_media.dart';
import 'package:chat/modules/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileDetails extends ConsumerWidget {
  const MyProfileDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider.notifier);
    final userData = ref.watch(getUserDataProvider(user.uid!));

    return userData.when(
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
        ],
      ),
    );
  }
}
