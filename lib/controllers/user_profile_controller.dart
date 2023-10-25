import 'dart:io';

import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/services/firebase_storage_service.dart';
import 'package:chat/core/utils/flutter_utils.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/repository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileController = StateNotifierProvider<UserProfileController, bool>(
  (ref) => UserProfileController(
    userProfileRepository: ref.read(userProfileRepositoryProvider),
    storageService: ref.read(storageServiceProvider),
    ref: ref,
  ),
);

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final StorageService _storageService;
  final Ref _ref;

  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required StorageService storageService,
    required Ref ref,
  })  : _userProfileRepository = userProfileRepository,
        _storageService = storageService,
        _ref = ref,
        super(false);

  editProfile({
    required BuildContext context,
    required String? name,
    required String? email,
    required String? bio,
    required File? avatar,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;

    if (avatar != null) {
      final res = await _storageService.storeFile(
        path: 'users/profile',
        id: user.uid,
        file: avatar,
      );
      res.fold(
        (error) => showSnackBar(context, error.message),
        (imageUrl) => user = user.copyWith(avatar: imageUrl),
      );
    }

    final updatedUser = user.copyWith(uid: user.uid, name: name, email: email, bio: bio);
    final res = await _userProfileRepository.editProfile(updatedUser);
    state = false;
    res.fold(
      (failure) => showSnackBar(context, failure.message),
      (userModel) {
        _ref.read(userProvider.notifier).update((_) => updatedUser);
        showSnackBar(context, "Profile has been updated");
      },
    );
  }
}
