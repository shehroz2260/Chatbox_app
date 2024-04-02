import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_functions.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/view/main_view/message_tab/chat_room/chat_room_controller.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:practice_project/widgets/image_preview.dart';
import 'package:resize/resize.dart';
import '../models/chat_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_gap.dart';
import '../utils/app_text_style.dart';
import 'video_player_view.dart';

class MessageBox extends StatelessWidget {
  final ChatModel model;
  final String profile;
  final int index;
  final bool isSender;
  final void Function()? onTap;
  const MessageBox({
    super.key,
    required this.profile,
    required this.model,
    required this.index,
    this.onTap,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    bool isShowTime = Get.find<ChatRoomController>().showTime(index);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 24, left: 24),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isShowTime)
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: AppColors.borderColor,
                  endIndent: 10.w,
                )),
                Text(AppFunction.getFormattedDate(model.messageTime)),
                Expanded(
                    child: Divider(
                  color: AppColors.borderColor,
                  indent: 10.w,
                )),
              ],
            ),
          if (isShowTime) AppGap.height16,
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isSender)
                AppCacheImage(
                    imageUrl: profile, height: 40.h, width: 40.w, round: 40),
              SizedBox(width: 10.w),
              Flexible(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: isSender ? 0 : 100.w,
                        left: isSender ? 100.w : 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isSender ? 12 : 0),
                            topRight: Radius.circular(isSender ? 0 : 12),
                            bottomLeft: const Radius.circular(12),
                            bottomRight: const Radius.circular(12)),
                        color: isSender
                            ? AppColors.greenColor
                            : AppColors.lightBlue),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (model.media != null &&
                            model.media!.type == MediaType.image)
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  ImageViewer(imageUrl: model.media!.url));
                            },
                            child: AppCacheImage(
                              height: 200,
                              width: Get.width,
                              imageUrl: model.media!.url,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                        if (model.media != null &&
                            model.media!.type == MediaType.video)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              AppCacheImage(
                                height: 200,
                                width: Get.width,
                                imageUrl: model.media!.thumbnail ?? "",
                                boxFit: BoxFit.cover,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VideoPlayerView(
                                      videoUrl: model.media!.url));
                                },
                                child: const Icon(
                                  Icons.play_circle,
                                  color: AppColors.appBgColor,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        if (model.media != null &&
                            model.media!.type == MediaType.file)
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.docs,
                                colorFilter: ColorFilter.mode(
                                    isSender
                                        ? AppColors.appBgColor
                                        : AppColors.blackColor,
                                    BlendMode.srcIn),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(model.media!.name,
                                    style: AppTextStyle.circularFont12.copyWith(
                                        color: isSender
                                            ? AppColors.appBgColor
                                            : AppColors.blackColor)),
                              )
                            ],
                          ),
                        if (model.message.isNotEmpty) const SizedBox(height: 5),
                        if (model.message.isNotEmpty)
                          Text(
                            model.message,
                            style: AppTextStyle.circularFont12.copyWith(
                                color: isSender
                                    ? AppColors.appBgColor
                                    : AppColors.blackColor),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // Padding(
          //     padding: EdgeInsets.only(right: senderId != "1" ? 100.w : 0),
          //     child: const Align(
          //         alignment: Alignment.centerRight, child: Text("time")))
        ],
      ),
    );
  }
}
