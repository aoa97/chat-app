import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final contactsRepositoryProvider = Provider(
  (ref) => ContactsRepository(
    firestore: ref.read(firestoreProvider),
    ref: ref,
  ),
);

class ContactsRepository {
  final Ref _ref;
  final FirebaseFirestore _firestore;
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  ContactsRepository({
    required Ref ref,
    required FirebaseFirestore firestore,
  })  : _ref = ref,
        _firestore = firestore;

  Stream<List<UserModel>> getContacts() {
    final authUserId = _ref.read(userProvider)!.uid;
    final snapshots = _users.where(FieldPath.documentId, isNotEqualTo: authUserId).snapshots();

    return snapshots.map(
      (snap) => [
        ...snap.docs.map(
          (doc) => UserModel.fromMap(
            map: doc.data() as Map<String, dynamic>,
            uid: doc.id,
          ),
        )
      ],
    );
  }
}
