import 'package:flutter/material.dart';

class MainCrossFade extends StatelessWidget {
  final Widget child;
  final bool visible;

  const MainCrossFade({super.key, required this.child, required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: child,
      secondChild: const SizedBox(),
      duration: const Duration(milliseconds: 300),
      crossFadeState: visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
