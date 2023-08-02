import 'package:chat/views/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final String image;
  final String user;
  final String message;
  final String createdAt;

  const RecentItem({
    super.key,
    required this.image,
    required this.user,
    required this.message,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: MainWrapper(
        child: ListTile(
          leading: CircleAvatar(
            radius: 21,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(image),
            ),
          ),
          title: Text(user, style: const TextStyle(fontSize: 14)),
          subtitle: Text(
            message,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(createdAt),
        ),
      ),
    );
  }
}
