import 'package:chat/core/utils/flutter_utils.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:chat/modules/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  ),
);

final authChangeProvider = StreamProvider((ref) {
  return ref.watch(authControllerProvider.notifier).authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(authControllerProvider.notifier).getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  final AuthRepository _authRepository;
  String? uid;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false) {
    authStateChange.first.then((user) => uid = user?.uid);
  }

  authWithEmail({
    required BuildContext context,
    required String email,
    required String password,
    required String? name,
  }) async {
    state = true;
    final user = (name != null && name.isNotEmpty)
        ? await _authRepository.registerWithEmail(email, password, name)
        : await _authRepository.loginWithEmail(email, password);
    state = false;
    user.fold(
      (failure) => showSnackBar(context, failure.message),
      (userModel) {
        _ref.read(userProvider.notifier).update((_) => userModel);
        uid = userModel.uid;
      },
    );
  }

  logOut() {
    _authRepository.logout();
  }

  Stream<UserModel> getUserData(String id) => _authRepository.getUserData(id);
  Stream<User?> get authStateChange => _authRepository.authStateChange;
}
