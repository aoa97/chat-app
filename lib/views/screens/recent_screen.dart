import 'package:chat/controllers/recent_controller.dart';
import 'package:chat/core/utils/constants.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/views/layouts/main_card.dart';
import 'package:chat/views/widgets/recent_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class RecentScreen extends ConsumerWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentStream = ref.watch(recentStreamProvider);

    return Column(
      children: [
        MainCard(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search by name",
              prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ),
          ),
        ),
        30.verticalSpace,
        Expanded(
          child: recentStream.when(
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (data) {
              if (data.isEmpty) {
                return const Center(child: Text(Constants.emptyRecent));
              }

              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final recent = data[index];

                  return RecentItem(
                    image: recent.avatar,
                    user: recent.name,
                    message: recent.text,
                    createdAt: recent.createdAt != null ? DateFormat('h:mm a').format(recent.createdAt!) : null,
                    onTap: () => context.pushNamed("/room", args: recent.roomId),
                  );
                },
                separatorBuilder: (c, i) => 15.verticalSpace,
                padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
              );
            },
          ),
        ),
      ],
    );
  }
}
