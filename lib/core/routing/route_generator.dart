import 'package:chat/core/routing/home_route_handler_widget.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:chat/modules/auth/controller/auth_controller.dart';
import 'package:chat/modules/chat-room/view/screens/chat_room_screen.dart';
import 'package:chat/modules/my-profile/view/screens/edit_profile_screen.dart';
import 'package:chat/modules/my-profile/view/screens/my_profile_screen.dart';
import 'package:chat/modules/public-profile/view/screens/public_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings, WidgetRef ref) {
    return switch (settings.name) {
      "/" => MaterialPageRoute(builder: (_) => const HomeRouteHandler()),
      "/profile" => () {
          final userId = settings.arguments as String?;

          if (userId == null) {
            return MaterialPageRoute(builder: (_) => const MyProfileScreen());
          }

          return MaterialPageRoute(builder: (_) => PublicProfileScreen(uid: userId));
        }(),
      "/edit-profile" => MaterialPageRoute(builder: (_) => const EditProfileScreen()),
      "/room" => () {
          final roomId = settings.arguments as String;
          return MaterialPageRoute(builder: (_) => ChatScreen(roomId: roomId));
        }(),
      "/user-room" => () {
          final otherId = settings.arguments as String;
          final myId = ref.read(userProvider)!.uid;
          return MaterialPageRoute(builder: (_) => ChatScreen(roomId: generateRoomId(myId, otherId)));
        }(),
      _ => null,
    };
  }
}
