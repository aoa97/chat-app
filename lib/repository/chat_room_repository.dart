import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/models/chat_message_model.dart';
import 'package:chat/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatRoomRepositoryProvider = Provider.family(
  (ProviderRef ref, String roomId) => ChatRoomRepository(
    firestore: ref.read(firestoreProvider),
    ref: ref,
    roomId: roomId,
  ),
);

class ChatRoomRepository {
  final Ref _ref;
  final String _roomId;
  final FirebaseFirestore _firestore;
  DocumentReference get _roomRef => _firestore.doc("chats/$_roomId");

  ChatRoomRepository({
    required Ref ref,
    required String roomId,
    required FirebaseFirestore firestore,
  })  : _ref = ref,
        _roomId = roomId,
        _firestore = firestore;

  Stream<List<ChatMessageModel>> getRoomMessages() {
    final snapshots = _roomRef.collection("messages").orderBy('created_at', descending: true).snapshots();

    return snapshots.map(
      (snap) => [
        ...snap.docs.map(
          (doc) => ChatMessageModel.fromMap(doc.data()).copyWith(
            id: doc.id,
            isMe: doc.data()["senderId"] == _ref.read(userProvider)!.uid,
          ),
        )
      ],
    );
  }
}
