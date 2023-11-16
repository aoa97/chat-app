import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/layouts/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool? showCard;
  final InputDecoration? inputDecoration;
  final int? maxLines;

  const MainTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.textInputAction,
    this.showCard = true,
    this.inputDecoration,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final input = TextFormField(
      controller: controller,
      cursorColor: context.colors.primary,
      decoration: inputDecoration ??
          InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      validator: validator,
      maxLines: maxLines ?? 1,
    );

    if (!showCard!) {
      return input;
    }

    return MainCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5).h,
        child: input,
      ),
    );
  }
}
