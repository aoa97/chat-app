import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/failure.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:chat/core/utils/type_defs.dart';
import 'package:chat/models/chat_header_model.dart';
import 'package:chat/models/chat_message_model.dart';
import 'package:chat/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
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
  CollectionReference get _usersRef => _firestore.collection(FirebaseConstants.usersCollection);
  DocumentReference get _roomRef => _firestore.doc("chats/$_roomId");

  ChatRoomRepository({
    required Ref ref,
    required String roomId,
    required FirebaseFirestore firestore,
  })  : _ref = ref,
        _roomId = roomId,
        _firestore = firestore;
  late final myId = _ref.read(userProvider)!.uid;

  Stream<ChatHeaderModel> getRoomHeader() {
    final otherUserId = extractOtherId(_roomId, myId);
    final snapshots = _usersRef.doc(otherUserId).snapshots();

    return snapshots.map(
      (doc) => ChatHeaderModel.fromMap(doc.data() as Map<String, dynamic>).copyWith(uid: doc.id),
    );
  }

  Stream<List<ChatMessageModel>> getRoomMessages() {
    final snapshots = _roomRef.collection("messages").orderBy('createdAt', descending: true).snapshots();

    return snapshots.map(
      (snap) => [
        ...snap.docs.map(
          (doc) => ChatMessageModel.fromMap(doc.data()).copyWith(
            id: doc.id,
            isMe: doc.data()["senderId"] == myId,
          ),
        )
      ],
    );
  }

  FutureVoid sendMessage(ChatMessageModel message) async {
    final messageBody = message.copyWith(senderId: myId);

    try {
      await _roomRef.collection("messages").add(messageBody.toMap());
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? ""));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
