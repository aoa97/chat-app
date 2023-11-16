import 'package:chat/controllers/chat_room_controller.dart';
import 'package:chat/views/layouts/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomInput extends HookConsumerWidget {
  final String roomId;

  const ChatRoomInput({super.key, required this.roomId});

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
          onSubmitted: (value) => sendMessage(),
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
