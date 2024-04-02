import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_cached_image.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  const ImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: InteractiveViewer(
              child: AppCacheImage(
                imageUrl: imageUrl,
                boxFit: BoxFit.fitWidth,
                width: Get.width,
                height: Get.height,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
