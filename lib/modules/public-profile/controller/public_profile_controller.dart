import 'package:chat/core/models/user_model.dart';
import 'package:chat/modules/public-profile/repository/public_profile_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicUserStreamProvider = StreamProvider.family<UserModel, String>((ref, id) {
  return ref.watch(publicProfileControllerProvider).getUserData(id);
});

final publicProfileControllerProvider = Provider(
  (ref) => PublicProfileController(
    publicProfileRepository: ref.read(publicProfileRepositoryProvider),
  ),
);

class PublicProfileController {
  final PublicProfileRepository _publicProfileRepository;

  PublicProfileController({
    required PublicProfileRepository publicProfileRepository,
  }) : _publicProfileRepository = publicProfileRepository;

  Stream<UserModel> getUserData(String id) => _publicProfileRepository.getUserData(id);
}
