import 'package:chat/core/utils/constants.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicProfileRepositoryProvider = Provider(
  (ref) => PublicProfileRepository(
    firestore: ref.read(firestoreProvider),
  ),
);

class PublicProfileRepository {
  final FirebaseFirestore _firestore;

  PublicProfileRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  Stream<UserModel> getUserData(String id) {
    return _users
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(map: snap.data() as Map<String, dynamic>, uid: snap.id));
  }
}
