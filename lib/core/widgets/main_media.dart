import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/core/utils/extensions.dart';
import 'package:chat/core/utils/flutter_assets.dart';
import 'package:flutter/material.dart';

class MainAvatar extends StatelessWidget {
  final String imageUrl;
  final double dimension;
  final double? strokeWidth;

  const MainAvatar({
    super.key,
    required this.imageUrl,
    required this.dimension,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: context.colors.primary, shape: BoxShape.circle),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: dimension,
        height: dimension,
        errorWidget: (context, url, error) => Assets.userAvatarPlacehoder,
      ),
    );
  }
}
