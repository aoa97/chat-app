import 'package:chat/views/containers/chat_room_header.dart';
import 'package:chat/views/containers/chat_room_input.dart';
import 'package:chat/views/containers/chat_room_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.08.sh),
        child: ChatRoomHeader(roomId: roomId),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ChatRoomMessages(roomId: roomId),
            ),
            ChatRoomInput(roomId: roomId),
          ],
        ),
      ),
    );
  }
}
