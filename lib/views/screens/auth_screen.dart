import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/containers/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:separated_column/separated_column.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.login,
          style: TextStyle(fontFamily: Fonts.bungee),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20).w,
        child: SeparatedColumn(
          separatorBuilder: (context, index) => 20.verticalSpace,
          children: [
            const MainCard(
              child: TextField(
                decoration: InputDecoration(hintText: "E-mail", prefixIcon: Icon(Icons.person)),
              ),
            ),
            const MainCard(
              child: TextField(
                decoration: InputDecoration(hintText: "Password", prefixIcon: Icon(Icons.password_outlined)),
              ),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: context.colors.inversePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5).r),
              ),
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
