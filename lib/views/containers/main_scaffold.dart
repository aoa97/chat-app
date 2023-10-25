import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/flutter_assets.dart';
import 'package:chat/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final List<Widget>? actions;

  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    this.padding,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontFamily: Fonts.bungee),
        ),
        titleSpacing: context.canPop ? 0 : Theme.of(context).appBarTheme.titleSpacing,
        leading: elseNull(
          condition: context.canPop,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: context.pop,
          ),
        ),
        actions: actions,
      ),
      body: Padding(
        padding: padding ?? const EdgeInsets.all(20).h,
        child: body,
      ),
    );
  }
}
