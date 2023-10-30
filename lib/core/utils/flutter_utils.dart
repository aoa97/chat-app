import 'dart:io';

import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

showMainBottomSheet({required BuildContext context, required Widget child}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.inversePrimary,
    builder: (context) => child,
  );
}

Future<File> pickImage({required ImageSource source}) async {
  final imagePicker = ImagePicker();
  final result = await imagePicker.pickImage(source: source);
  return File(result!.path);
}

Future<File?> showMainImageSelector(BuildContext context) async {
  File? pickedImage;

  await showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text(Constants.gallery),
          onTap: () {
            pickImage(source: ImageSource.gallery).then((result) {
              pickedImage = File(result.path);
              Navigator.pop(context);
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text(Constants.camera),
          onTap: () {
            pickImage(source: ImageSource.camera).then((result) {
              pickedImage = File(result.path);
              Navigator.pop(context);
            });
          },
        ),
      ],
    ),
  );

  return pickedImage;
}
