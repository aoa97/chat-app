import 'package:chat/modules/chat-room/controller/chat_room_controller.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomHeader extends ConsumerWidget {
  final String roomId;

  const ChatRoomHeader({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: context.colors.inversePrimary,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: context.colors.primary),
        onPressed: () => Navigator.pop(context),
      ),
      title: ref.watch(chatHeaderStreamProvider(roomId)).when(
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
            data: (data) => GestureDetector(
              onTap: () => context.pushNamed("/profile", args: data.uid),
              child: Row(
                children: [
                  MainAvatar(
                    imageUrl: data.avatar,
                    dimension: 35.h,
                  ),
                  10.horizontalSpace,
                  Text(
                    data.name,
                    style: TextStyle(fontSize: 18.sp, color: context.colors.primary),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
