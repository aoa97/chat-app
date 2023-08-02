import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;

  const MainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.black),
        ),
        shadows: const [BoxShadow(offset: Offset(6, 5))],
      ),
      child: child,
    );
  }
}
