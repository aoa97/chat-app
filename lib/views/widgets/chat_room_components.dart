part of "../screens/chat_room_screen.dart";

class ChatRoomBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatRoomBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe! ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe!) ...[
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
                child: Text(message.text!, style: TextStyle(fontSize: 12.sp)),
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
  }
}

class _ChatRoomInput extends HookConsumerWidget {
  final String roomId;

  const _ChatRoomInput({required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = useTextEditingController(text: "");
    final enableSubmit = useState<bool>(false);
    final isLoading = ref.watch(chatRoomControllerProvider(roomId));

    sendMessage() async {
      await ref.read(chatRoomControllerProvider(roomId).notifier).sendMessage(text: text.text);
      text.clear();
    }

    return Container(
      margin: const EdgeInsets.all(15).h,
      child: MainCard(
        thin: true,
        child: TextField(
          controller: text,
          onChanged: (value) => enableSubmit.value = value.isNotEmpty,
          decoration: InputDecoration(
            hintText: "Enter your message...",
            prefixIcon: IconButton(
              icon: isLoading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              onPressed: !enableSubmit.value ? null : sendMessage,
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
