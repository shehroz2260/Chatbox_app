import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayController extends GetxController {
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  ChewieController? _chewieController;
  ChewieController? get chewieController => _chewieController;
  void initData(String videoUrl) async {
    final file = await DefaultCacheManager().getSingleFile(videoUrl);

    _videoPlayerController = VideoPlayerController.file(file);
    await _videoPlayerController!.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        // allowFullScreen: true,
        autoPlay: true,
        looping: true,
        allowPlaybackSpeedChanging: true,
        // allowMuting: true,
        fullScreenByDefault: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);

    update();
  }

  void disposeData() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }
}
