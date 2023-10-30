import 'dart:io';

import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/controllers/user_profile_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/flutter_assets.dart';
import 'package:chat/core/utils/flutter_utils.dart';
import 'package:chat/core/utils/validators.dart';
import 'package:chat/views/containers/main_scaffold.dart';
import 'package:chat/views/widgets/main_button.dart';
import 'package:chat/views/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:separated_column/separated_column.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final name = useTextEditingController(text: user?.name);
    final email = useTextEditingController(text: user?.email);
    final bio = useTextEditingController(text: user?.bio);
    final avatar = useState<File?>(null);
    final isLoading = ref.watch(userProfileController);

    handleSubmit() {
      if (formKey.currentState!.validate()) {
        ref.read(userProfileController.notifier).editProfile(
              context: context,
              name: name.text,
              email: email.text,
              bio: bio.text,
              avatar: avatar.value,
            );
      }
    }

    return MainScaffold(
      title: Constants.editProfile,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SeparatedColumn(
            separatorBuilder: (context, index) => 20.verticalSpace,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 100.h,
                      height: 100.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        image: avatar.value != null
                            ? FileImage(avatar.value!)
                            : NetworkImage(user!.avatar ?? "") as ImageProvider,
                        errorBuilder: (context, error, stackTrace) => Assets.userAvatarPlacehoder,
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () async {
                        avatar.value = await showMainImageSelector(context);
                      },
                      icon: Icon(Icons.camera_alt, color: context.colors.inversePrimary),
                    ),
                  ],
                ),
              ),
              MainTextField(
                showCard: false,
                controller: name,
                hintText: Constants.fullName,
                validator: FieldValidators.validateName(),
              ),
              MainTextField(
                showCard: false,
                controller: email,
                hintText: Constants.email,
                validator: FieldValidators.validateEmail(),
              ),
              MainTextField(
                showCard: false,
                maxLines: 5,
                controller: bio,
                hintText: Constants.bio,
                validator: FieldValidators.validateBio(),
              ),
              MainButton(
                onPressed: handleSubmit,
                loading: isLoading,
                label: Constants.submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
