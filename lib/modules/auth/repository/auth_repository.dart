import 'package:chat/core/models/user_model.dart';
import 'package:chat/core/providers/firebase_providers.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/failure.dart';
import 'package:chat/core/utils/type_defs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(auth: ref.read(authProvider), firestore: ref.read(firestoreProvider)),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);
  User? get _authUser => FirebaseAuth.instance.currentUser;

  FutureEither<UserModel> registerWithEmail(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final userModel = UserModel(
        uid: _authUser!.uid,
        email: _authUser!.email ?? "",
        name: name,
        avatar: Constants.avatarPlaceholderUrl,
        bio: null,
      );

      await _users.doc(userCredential.user!.uid).set(userModel.toMap());

      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> loginWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      final userModel = await getUserData(userCredential.user!.uid).first;

      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? ""));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid logout() async {
    try {
      await _auth.signOut();
      return right(null);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String id) {
    return _users
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(map: snap.data() as Map<String, dynamic>, uid: snap.id));
  }

  Stream<User?> get authStateChange => _auth.authStateChanges();
}
