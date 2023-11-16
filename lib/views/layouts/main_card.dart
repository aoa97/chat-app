import 'package:chat/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final bool? thin;

  const MainCard({super.key, required this.child, this.thin = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.inversePrimary,
        shape: BeveledRectangleBorder(
          borderRadius: thin! ? BorderRadius.zero : BorderRadius.circular(5),
          side: BorderSide(color: context.colors.primary),
        ),
        shadows: [
          BoxShadow(
            offset: thin! ? const Offset(3, 2) : const Offset(6, 5),
            color: context.colors.primary,
          ),
        ],
      ),
      child: child,
    );
  }
}
