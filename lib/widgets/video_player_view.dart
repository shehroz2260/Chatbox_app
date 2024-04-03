import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_colors.dart';
import '../controllers/video_player_controller.dart';

class VideoPlayerView extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerView({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoPlayController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<VideoPlayController>(
        initState: (state) {
          controller.initData(videoUrl);
        },
        dispose: (state) {
          controller.disposeData();
        },
        builder: (_) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: controller.videoPlayerController != null &&
                        controller.videoPlayerController!.value.isInitialized
                    ? Chewie(controller: controller.chewieController!)
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.greenColor,
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
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
