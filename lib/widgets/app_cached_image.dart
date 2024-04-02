import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCacheImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final Widget? imageFailWidget;
  final double? round;
  final bool? showNative;
  final double? opacity;
  final VoidCallback? onTap;
  final double? marginHorizontal;
  final double? marginVertical;
  final bool? showSpinKit;
  final BoxFit? boxFit;

  const AppCacheImage(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.round,
      this.imageFailWidget,
      this.showNative,
      this.onTap,
      this.marginHorizontal,
      this.marginVertical,
      this.showSpinKit = false,
      this.boxFit,
      this.opacity});

  @override
  Widget build(BuildContext context) {
    int cacheHeight = Get.size.height.toInt();
    int cacheWidth = Get.size.width.toInt();
    if (height != null && height != double.infinity) {
      cacheHeight = height?.toInt() ?? 0;
    }
    if (width != null && width != double.infinity) {
      cacheWidth = width?.toInt() ?? 0;
    }
    cacheWidth = cacheWidth < 50 ? 100 : cacheWidth;
    cacheHeight = cacheHeight < 50 ? 100 : cacheWidth;
    var widget = Container(
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal ?? 0, vertical: marginVertical ?? 0),
      width: width,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(round ?? 20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(round ?? 20),
        child: CachedNetworkImage(
          width: width,
          height: height,
          maxHeightDiskCache: cacheHeight,
          maxWidthDiskCache: cacheWidth,
          memCacheHeight: cacheHeight,
          memCacheWidth: cacheWidth,
          fit: boxFit ?? BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => Container(
              color: Colors.black.withOpacity(.04),
              width: height,
              height: height,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
              )),
          errorWidget: (context, url, error) =>
              imageFailWidget ??
              Container(
                  color: Colors.black.withOpacity(.04),
                  width: height,
                  height: height,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.image),
                  )),
        ),
      ),
    );
    if (onTap == null) return widget;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: widget,
    );
  }
}
