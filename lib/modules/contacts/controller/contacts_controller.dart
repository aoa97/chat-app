import 'package:chat/modules/contacts/repository/contacts_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final contactsStreamProvider = StreamProvider((ref) {
  return ref.watch(contactsControllerProvider).contactsStream;
});

final contactsControllerProvider = Provider(
  (ref) => ContactsController(contactsRepository: ref.read(contactsRepositoryProvider)),
);

class ContactsController {
  final ContactsRepository _contactsRepository;

  ContactsController({
    required ContactsRepository contactsRepository,
  }) : _contactsRepository = contactsRepository;

  late final contactsStream = _contactsRepository.getContacts();
}
