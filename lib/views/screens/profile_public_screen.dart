import 'package:chat/controllers/public_profile_controller.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PublicProfileScreen extends ConsumerWidget {
  final String uid;

  const PublicProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.colors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10).h,
        child: ref.watch(publicUserStreamProvider(uid)).when(
              error: (error, stackTrace) => const SizedBox(),
              loading: () => const SizedBox(),
              data: (profile) => Column(
                children: [
                  Center(
                    child: MainAvatar(
                      imageUrl: profile.avatar ?? "",
                      dimension: 120.h,
                      strokeWidth: 2,
                    ),
                  ),
                  7.5.verticalSpace,
                  Text(
                    profile.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    profile.email,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colors.secondary.withOpacity(.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (profile.bio != null) ...[
                    7.5.verticalSpace,
                    Text(
                      profile.bio!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp, color: context.colors.secondary),
                    ),
                  ]
                ],
              ),
            ),
      ),
    );
  }
}
