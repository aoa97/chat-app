part of "../screens/chat_room_screen.dart";

class _ChatRoomBubble extends StatelessWidget {
  final ChatMessageModel message;

  const _ChatRoomBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            Container(
              width: 30.h,
              height: 30.h,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              child: Image.network("https://picsum.photos/45"),
            ),
            10.horizontalSpace,
          ],
          Column(
            crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14).h,
                decoration: BoxDecoration(
                  color: message.isMe ? const Color(0xFFe3e3e3) : context.colors.inversePrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: !message.isMe ? Radius.zero : const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    bottomLeft: const Radius.circular(8),
                    bottomRight: const Radius.circular(8),
                  ),
                ),
                child: Text(message.text, style: TextStyle(fontSize: 12.sp)),
              ),
              5.verticalSpace,
              const Text(
                "1:02 PM",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatRoomInput extends StatelessWidget {
  const _ChatRoomInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15).h,
      child: MainCard(
        thin: true,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Enter your message...",
            prefixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {},
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatRoomSeparator extends StatelessWidget {
  final String label;

  const _ChatRoomSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 14).h,
        padding: const EdgeInsets.all(5).h,
        decoration: BoxDecoration(
          color: const Color(0xFFe3e3e3),
          borderRadius: BorderRadius.circular(8).r,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 10.sp),
        ),
      ),
    );
  }
}
