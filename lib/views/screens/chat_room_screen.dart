import 'package:chat/controllers/chat_room_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/models/chat_message_model.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part "../widgets/chat_room_components.dart";

class ChatScreen extends ConsumerWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(roomMessagesStreamProvider(roomId));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: context.colors.inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.colors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 35.h,
              height: 35.h,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              child: Image.network("https://picsum.photos/45"),
            ),
            10.horizontalSpace,
            Text(
              "Ahmed Usama",
              style: TextStyle(fontSize: 18.sp, color: context.colors.primary),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messages.when(
                error: (error, stackTrace) => Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text(Constants.emptyMessages));
                  }

                  return GroupedListView(
                    elements: data,
                    padding: const EdgeInsets.all(12).h,
                    groupBy: (message) => message.createdAt.day,
                    itemBuilder: (context, message) => _ChatRoomBubble(message: message),
                    groupHeaderBuilder: (message) => _ChatRoomSeparator(
                      label: message.createdAt.toString().split(" ")[0],
                    ),
                    separator: 7.verticalSpace,
                  );
                },
              ),
            ),
            const _ChatRoomInput(),
          ],
        ),
      ),
    );
  }
}
