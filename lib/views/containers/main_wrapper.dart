import 'package:chat/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;

  const MainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.primary,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: context.colors.inversePrimary),
        ),
        shadows: [BoxShadow(offset: const Offset(6, 5), color: context.colors.inversePrimary)],
      ),
      child: child,
    );
  }
}
