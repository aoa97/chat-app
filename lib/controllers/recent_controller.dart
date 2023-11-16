import 'package:chat/repository/recent_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final recentStreamProvider = StreamProvider((ref) {
  return ref.watch(recentControllerProvider).recentStream;
});

final recentControllerProvider = Provider(
  (ref) => RecentController(contactsRepository: ref.read(recentRepositoryProvider)),
);

class RecentController {
  final RecentRepository _contactsRepository;

  RecentController({
    required RecentRepository contactsRepository,
  }) : _contactsRepository = contactsRepository;

  late final recentStream = _contactsRepository.getRecentChats();
}
