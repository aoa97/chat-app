import 'package:chat/modules/chat-room/controller/chat_room_controller.dart';
import 'package:chat/modules/chat-room/models/chat_message_model.dart';
import 'package:chat/modules/chat-room/view/widgets/chat_room_bubble.dart';
import 'package:chat/modules/chat-room/view/widgets/chat_room_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomMessages extends ConsumerWidget {
  final String roomId;

  const ChatRoomMessages({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(chatRoomControllerProvider(roomId).notifier).roomMessagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          final messages = snapshot.data ?? [];

          return GroupedListView<ChatMessageModel, int?>(
            elements: messages,
            reverse: true,
            sort: false,
            padding: const EdgeInsets.all(12).h,
            groupBy: (message) => message.createdAt?.day,
            itemBuilder: (context, message) => ChatRoomBubble(
              key: ValueKey(message.id),
              message: message,
              roomId: roomId,
            ),
            groupHeaderBuilder: (message) {
              if (message.createdAt == null) {
                return const SizedBox();
              }

              return ChatRoomSeparator(
                label: message.createdAt.toString().split(" ")[0],
              );
            },
            separator: 7.verticalSpace,
          );
        }

        return const SizedBox();
      },
    );
  }
}
