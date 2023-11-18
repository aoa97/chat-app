import 'package:chat/core/models/user_model.dart';
import 'package:chat/core/widgets/main_layout.dart';
import 'package:chat/modules/auth/controller/auth_controller.dart';
import 'package:chat/modules/auth/view/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeRouteHandler extends HookConsumerWidget {
  const HomeRouteHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = useState<UserModel?>(null);

    void getData(WidgetRef ref, User data) async {
      userModel.value = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
      ref.read(userProvider.notifier).update((state) => userModel.value);
    }

    return ref.watch(authChangeProvider).when(
          data: (data) {
            if (data != null) {
              getData(ref, data);
              return const MainLayout();
            }
            return const AuthScreen();
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
