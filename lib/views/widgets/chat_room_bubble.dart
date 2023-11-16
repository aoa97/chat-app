import 'package:chat/controllers/chat_room_controller.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/models/chat_message_model.dart';
import 'package:chat/views/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ChatRoomBubble extends StatelessWidget {
  final ChatMessageModel message;
  final String roomId;

  const ChatRoomBubble({super.key, required this.message, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: message.isMe! ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isMe!) ...[
              Consumer(
                builder: (context, ref, child) {
                  final chatHeaderStream = ref.watch(chatHeaderStreamProvider(roomId));

                  return chatHeaderStream.when(
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    data: (data) => MainAvatar(
                      imageUrl: data.avatar,
                      dimension: 30.h,
                    ),
                  );
                },
              ),
              10.horizontalSpace,
            ],
            Column(
              crossAxisAlignment: message.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14).h,
                  decoration: BoxDecoration(
                    color: message.isMe! ? const Color(0xFFe3e3e3) : context.colors.inversePrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: !message.isMe! ? Radius.zero : const Radius.circular(8),
                      topRight: const Radius.circular(8),
                      bottomLeft: const Radius.circular(8),
                      bottomRight: const Radius.circular(8),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth - 100.w,
                    ),
                    child: Text(
                      message.text!,
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    ),
                  ),
                ),
                5.verticalSpace,
                if (message.createdAt != null)
                  Text(
                    DateFormat('h:mm a').format(message.createdAt!),
                    style: const TextStyle(fontSize: 10),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
