import 'package:chat/repository/chat_room_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final roomMessagesStreamProvider = StreamProvider.family((ref, String roomId) {
  return ref.watch(chatRoomControllerProvider(roomId)).chatRoomStream;
});

final chatRoomControllerProvider = Provider.family(
  (ref, String roomId) => ChatRoomController(
    chatRoomRepository: ref.read(chatRoomRepositoryProvider(roomId)),
  ),
);

class ChatRoomController {
  final ChatRoomRepository _chatRoomRepository;

  ChatRoomController({
    required ChatRoomRepository chatRoomRepository,
  }) : _chatRoomRepository = chatRoomRepository;

  late final chatRoomStream = _chatRoomRepository.getRoomMessages();
}
