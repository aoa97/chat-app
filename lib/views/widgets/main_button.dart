import 'package:chat/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MainButtonType { filled, outlined, text }

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final Widget? child;
  final Widget? icon;
  final MainButtonType? type;
  final bool? loading;
  final bool? expanded;

  const MainButton({
    super.key,
    required this.onPressed,
    this.label,
    this.child,
    this.icon,
    this.type = MainButtonType.filled,
    this.loading = false,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded! ? double.infinity : null,
      child: Builder(
        builder: (context) {
          if (type == MainButtonType.text) {
            return TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(foregroundColor: context.colors.inversePrimary),
              child: Text(label!),
            );
          }

          if (type == MainButtonType.outlined) {
            if (icon != null) {
              return OutlinedButton.icon(
                onPressed: onPressed,
                icon: icon!,
                label: child!,
                style: OutlinedButton.styleFrom(backgroundColor: context.colors.primary),
              );
            }
            return OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(backgroundColor: context.colors.primary),
              child: child ?? Text(label!),
            );
          }

          return FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: context.colors.onSurface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5).r),
            ),
            child: () {
              if (child != null) return child;
              if (loading!) {
                return SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 1.7.w));
              }
              return Text(label!, style: TextStyle(color: context.colors.primary));
            }(),
          );
        },
      ),
    );
  }
}
