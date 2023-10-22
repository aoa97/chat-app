import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';

part "../widgets/chat_room_components.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: GroupedListView(
                elements: dummyMessages,
                padding: const EdgeInsets.all(12).h,
                groupBy: (message) => message.dateTime.day,
                itemBuilder: (context, message) => _ChatRoomBubble(message: message),
                groupHeaderBuilder: (message) => _ChatRoomSeparator(
                  label: message.dateTime.toString().split(" ")[0],
                ),
                separator: 7.verticalSpace,
              ),
            ),
            const _ChatRoomInput(),
          ],
        ),
      ),
    );
  }
}

class ChatMessageModel {
  final String id;
  final String senderId;
  final DateTime dateTime;
  final String text;
  final bool isMe;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.dateTime,
    required this.text,
    required this.isMe,
  });
}

final dummyMessages = [
  ChatMessageModel(
    id: "1",
    senderId: "10",
    dateTime: DateTime(2023, 10, 18, 12, 0, 0),
    text: "Received Message",
    isMe: false,
  ),
  ChatMessageModel(
    id: "3",
    senderId: "11",
    dateTime: DateTime(2023, 10, 18, 12, 1, 0),
    text: "Sent Message",
    isMe: true,
  ),
  ChatMessageModel(
    id: "2",
    senderId: "10",
    dateTime: DateTime(2023, 10, 17, 12, 0, 0),
    text: "Received Message",
    isMe: false,
  ),
  ChatMessageModel(
    id: "4",
    senderId: "11",
    dateTime: DateTime(2023, 10, 17, 12, 1, 0),
    text: "Sent Message",
    isMe: true,
  ),
];
