import 'package:chat/core/providers/firebase_providers.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:chat/modules/auth/controller/auth_controller.dart';
import 'package:chat/modules/recent/models/recent_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final recentRepositoryProvider = Provider(
  (ref) => RecentRepository(
    firestore: ref.read(firestoreProvider),
    ref: ref,
  ),
);

class RecentRepository {
  final Ref _ref;
  final FirebaseFirestore _firestore;
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _chats => _firestore.collection(FirebaseConstants.chatsCollection);

  RecentRepository({
    required Ref ref,
    required FirebaseFirestore firestore,
  })  : _ref = ref,
        _firestore = firestore;

  Stream<List<RecentChatModel>> getRecentChats() {
    final myId = _ref.read(authControllerProvider.notifier).uid!;
    final userChatsStream = _users.doc(myId).collection("chats").snapshots();

    return userChatsStream.switchMap((userChatSnap) {
      final combinedStreams = [
        ...userChatSnap.docs.map((roomDoc) {
          final otherUserDataStream = _users.doc(extractOtherId(roomDoc.id, myId)).snapshots();
          final recentMessageStream = _chats
              .doc(roomDoc.id)
              .collection("chats")
              .orderBy("createdAt", descending: true)
              .limit(1)
              .snapshots();
          return Rx.combineLatest2(
            otherUserDataStream,
            recentMessageStream,
            (otherUserDataSnap, recentMessageSnap) {
              final userData = otherUserDataSnap.data() as Map<String, dynamic>;
              final recentMessageData = recentMessageSnap.docs.firstOrNull?.data();

              return RecentChatModel(
                roomId: roomDoc.id,
                name: userData["name"],
                avatar: userData["avatar"],
                text: recentMessageData?["text"],
                createdAt: recentMessageData?["createdAt"] != null
                    ? (recentMessageData?["createdAt"] as Timestamp).toDate()
                    : null,
              );
            },
          );
        })
      ];

      if (combinedStreams.isEmpty) {
        return Stream.value([]);
      }

      return Rx.combineLatestList(combinedStreams).map((chats) {
        final recentChats = [...chats];
        recentChats.sort((a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);
        return recentChats;
      });
    });
  }
}
