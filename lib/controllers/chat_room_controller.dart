import 'package:chat/models/chat_header_model.dart';
import 'package:chat/models/chat_message_model.dart';
import 'package:chat/repository/chat_room_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatHeaderStreamProvider = StreamProvider.family<ChatHeaderModel, String>((ref, String roomId) {
  return ref.read(chatRoomControllerProvider(roomId).notifier).roomHeaderStream;
});

final chatRoomControllerProvider = StateNotifierProvider.family<ChatRoomController, bool, String>(
  (ref, String roomId) => ChatRoomController(
    chatRoomRepository: ref.read(chatRoomRepositoryProvider(roomId)),
  ),
);

class ChatRoomController extends StateNotifier<bool> {
  final ChatRoomRepository _chatRoomRepository;

  ChatRoomController({
    required ChatRoomRepository chatRoomRepository,
  })  : _chatRoomRepository = chatRoomRepository,
        super(false);

  Future<void> sendMessage({required String text}) async {
    state = true;
    final response = await _chatRoomRepository.sendMessage(
      ChatMessageModel(
        text: text,
      ),
    );
    state = false;
    response.fold((l) => l.message, (r) => null);
  }

  late final roomHeaderStream = _chatRoomRepository.getRoomHeader();
  late final roomMessagesStream = _chatRoomRepository.getRoomMessages();
}
