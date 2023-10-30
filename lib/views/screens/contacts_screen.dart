import 'package:chat/controllers/contacts_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:chat/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsStreamProvider);

    return Column(
      children: [
        MainCard(
          child: TextField(
            decoration: InputDecoration(
              hintText: Constants.searchByNameHint,
              prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ),
          ),
        ),
        30.verticalSpace,
        Expanded(
          child: contacts.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (data) {
              if (data.isEmpty) {
                return const Center(child: Text(Constants.emptyContacts));
              }

              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final contact = data[index];

                  return ContactItem(
                    id: contact.uid,
                    image: contact.avatar ?? "",
                    name: contact.name,
                    bio: contact.bio,
                    onTap: () => context.pushNamed("/user-room", args: contact.uid),
                  );
                },
                separatorBuilder: (c, i) => 15.verticalSpace,
                padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
              );
            },
          ),
        ),
      ],
    );
  }
}
