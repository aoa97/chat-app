import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/validators.dart';
import 'package:chat/views/layouts/main_scaffold.dart';
import 'package:chat/views/widgets/main_button.dart';
import 'package:chat/views/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:separated_column/separated_column.dart';

final isLoginModeProvider = StateProvider((ref) => false);

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormKey = useMemoized(GlobalKey<FormState>.new);
    final name = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final isLogin = ref.watch(isLoginModeProvider);
    final controller = ref.read(authControllerProvider.notifier);
    final isLoading = ref.watch(authControllerProvider);

    void authUser() {
      if (loginFormKey.currentState!.validate()) {
        controller.authWithEmail(
          context: context,
          email: email.text.trim(),
          password: password.text.trim(),
          name: name.text.trim(),
        );
      }
    }

    return MainScaffold(
      title: isLogin ? Constants.login : Constants.register,
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          child: SeparatedColumn(
            separatorBuilder: (context, index) => 20.verticalSpace,
            children: [
              if (!isLogin)
                MainTextField(
                  controller: name,
                  hintText: Constants.fullName,
                  prefixIcon: const Icon(Icons.person),
                  validator: FieldValidators.validateName(),
                ),
              MainTextField(
                controller: email,
                hintText: Constants.email,
                prefixIcon: const Icon(Icons.email),
                validator: FieldValidators.validateEmail(),
              ),
              MainTextField(
                controller: password,
                obscureText: true,
                hintText: Constants.password,
                prefixIcon: const Icon(Icons.password_outlined),
                textInputAction: TextInputAction.go,
                validator: FieldValidators.validatePassword(),
              ),
              MainButton(
                label: isLogin ? Constants.login : Constants.register,
                onPressed: authUser,
                loading: isLoading,
              ),
              MainButton(
                type: MainButtonType.text,
                onPressed: () => ref.read(isLoginModeProvider.notifier).update((state) => !state),
                label: isLogin ? Constants.noAccountHint : Constants.alreadyAccountHint,
              )
            ],
          ),
        ),
      ),
    );
  }
}
