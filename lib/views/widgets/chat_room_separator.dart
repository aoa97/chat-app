import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomSeparator extends StatelessWidget {
  final String label;

  const ChatRoomSeparator({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 14).h,
        padding: const EdgeInsets.all(5).h,
        decoration: BoxDecoration(
          color: const Color(0xFFe3e3e3),
          borderRadius: BorderRadius.circular(8).r,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: Colors.black),
        ),
      ),
    );
  }
}
