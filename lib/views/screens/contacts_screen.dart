import 'package:chat/views/containers/main_card.dart';
import 'package:chat/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainCard(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search by name",
              prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ),
          ),
        ),
        30.verticalSpace,
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            itemBuilder: (c, i) => const ContactItem(
              image: "https://picsum.photos/50",
              name: "Ahmed Usama",
              bio: "This is a contact bio",
            ),
            separatorBuilder: (c, i) => 15.verticalSpace,
            padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
          ),
        ),
      ],
    );
  }
}
