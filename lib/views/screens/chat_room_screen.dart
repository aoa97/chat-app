import 'package:chat/controllers/chat_room_controller.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/models/chat_message_model.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

part "../widgets/chat_room_components.dart";

class ChatScreen extends ConsumerWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatHeaderStream = ref.watch(chatHeaderStreamProvider(roomId));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: context.colors.inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.colors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: chatHeaderStream.when(
          loading: () => const SizedBox.shrink(),
          error: (error, stackTrace) => const SizedBox.shrink(),
          data: (data) => Row(
            children: [
              Container(
                width: 35.h,
                height: 35.h,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: Image.network(data.avatar),
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
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
                      ),
                      groupHeaderBuilder: (message) {
                        if (message.createdAt == null) {
                          return const SizedBox();
                        }

                        return _ChatRoomSeparator(
                          label: message.createdAt.toString().split(" ")[0],
                        );
                      },
                      separator: 7.verticalSpace,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            _ChatRoomInput(roomId: roomId),
          ],
        ),
      ),
    );
  }
}
