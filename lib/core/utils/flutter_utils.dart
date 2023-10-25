import 'dart:io';

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
    builder: (context) => child,
  );
}

Future<File> pickImage({required ImageSource source}) async {
  final imagePicker = ImagePicker();
  final result = await imagePicker.pickImage(source: source);
  return File(result!.path);
}
