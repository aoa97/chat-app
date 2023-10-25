import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/failure.dart';
import 'package:chat/core/utils/type_defs.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileRepositoryProvider = Provider(
  (ref) => UserProfileRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class UserProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserProfileRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid editProfile(UserModel user) async {
    try {
      await Future.wait([
        _users.doc(user.uid).update(user.toMap()),
        // _auth.currentUser!.updateDisplayName(user.name),
        // _auth.currentUser!.updateEmail(user.email),
        // _auth.currentUser!.updatePhotoURL(user.avatar),
      ]);
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
