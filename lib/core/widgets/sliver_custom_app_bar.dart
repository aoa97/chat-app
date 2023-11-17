import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/widgets/main_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransitionAppBar extends StatelessWidget {
  const TransitionAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.viewPaddingOf(context).top,
      ),
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: _TransitionAppBarDelegate(),
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / 200; // [...] of maxExtent
    final titleAlignTween = AlignmentTween(begin: Alignment.center, end: Alignment.centerLeft);
    final titleMarginTween = EdgeInsetsTween(
      begin: const EdgeInsets.only(top: 150.0 + 5.0),
      end: const EdgeInsets.only(left: 10.0 + 50.0 + 5.0),
    );
    final avatarSizeTween = SizeTween(begin: const Size(150.0, 150.0), end: const Size(50.0, 50.0));
    final avatarAlignTween = AlignmentTween(begin: Alignment.topCenter, end: Alignment.centerLeft);
    final avatarMarginTween = EdgeInsetsTween(begin: EdgeInsets.zero, end: const EdgeInsets.only(left: 10.0));

    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            alignment: avatarAlignTween.lerp(progress),
            margin: avatarMarginTween.lerp(progress),
            child: MainAvatar(
              imageUrl: "",
              dimension: avatarSizeTween.lerp(progress)!.height,
              strokeWidth: 2,
            ),
          ),
          Container(
            alignment: titleAlignTween.lerp(progress),
            margin: titleMarginTween.lerp(progress),
            child: Text(
              "Ahmed Usama",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: context.colors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) => true;
}


// class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final _avatarTween = SizeTween(begin: const Size(150.0, 150.0), end: const Size(50.0, 50.0));
//   final _avatarMarginTween = EdgeInsetsTween(begin: EdgeInsets.zero, end: const EdgeInsets.only(left: 10.0));
//   final _avatarAlignTween = AlignmentTween(begin: Alignment.topCenter, end: Alignment.centerLeft);

  // final _titleMarginTween = EdgeInsetsTween(
  //     begin: const EdgeInsets.only(top: 150.0 + 5.0), end: const EdgeInsets.only(left: 10.0 + 50.0 + 5.0));
//   final _titleAlignTween = AlignmentTween(begin: Alignment.center, end: Alignment.centerLeft);

//   final Widget avatar;
//   final Widget title;

//   _TransitionAppBarDelegate({required this.avatar, required this.title});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final progress = shrinkOffset / 200.0;

//     final avatarSize = _avatarTween.lerp(progress);
//     final avatarMargin = _avatarMarginTween.lerp(progress);
//     final avatarAlign = _avatarAlignTween.lerp(progress);

//     final titleMargin = _titleMarginTween.lerp(progress);
//     final titleAlign = _titleAlignTween.lerp(progress);
  //   return Stack(
  //     fit: StackFit.expand,
  //     children: <Widget>[
  //       Padding(
  //         padding: avatarMargin,
  //         child: Align(
  //           alignment: avatarAlign,
  //           child: SizedBox.fromSize(size: avatarSize, child: avatar),
  //         ),
  //       ),
  //       Padding(
  //         padding: titleMargin,
  //         child: Align(
  //           alignment: titleAlign,
  //           child: DefaultTextStyle(style: Theme.of(context).textTheme.titleLarge!, child: title),
  //         ),
  //       )
  //     ],
  //   );
  // }

//   @override
//   double get maxExtent => 200.0;

//   @override
//   double get minExtent => 100.0;

//   @override
  // bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
  //   return avatar != oldDelegate.avatar || title != oldDelegate.title;
  // }
// }
