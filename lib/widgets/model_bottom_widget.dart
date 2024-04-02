import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_gap.dart';
import '../utils/app_text_style.dart';
import '../utils/media_type.dart';
import '../view/main_view/message_tab/chat_room/chat_room_controller.dart';

class ModelBottomWidget extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  const ModelBottomWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 44.h,
              width: 44.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.lightBlue, shape: BoxShape.circle),
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(width: 15),
            Text(title)
          ],
        ),
      ),
    );
  }
}

class CustomModelBottomSheet {
  static void modelBottomSheet() {
    final controller = Get.find<ChatRoomController>();
    showModalBottomSheet(
        context: Get.context!,
        builder: (cont) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            width: Get.width,
            child: Column(
              children: [
                AppGap.height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: Get.back,
                        child: const Icon(Icons.cancel_outlined)),
                    const Text("Share Media"),
                    const SizedBox(width: 20)
                  ],
                ),
                AppGap.height30,
                ModelBottomWidget(
                  icon: AppAssets.camera,
                  onTap: () {
                    Get.back();
                    controller.pickImage(true, false);
                  },
                  title: "Camera",
                ),
                ModelBottomWidget(
                  icon: AppAssets.docs,
                  onTap: () {
                    Get.back();
                    controller.pickFile();
                  },
                  title: "Documents",
                ),
                ModelBottomWidget(
                  icon: AppAssets.media,
                  onTap: () {
                    Get.back();
                    controller.pickImage(false, true);
                  },
                  title: "Videos",
                ),
                ModelBottomWidget(
                  icon: AppAssets.userIcon,
                  onTap: () {},
                  title: "Contact",
                ),
                ModelBottomWidget(
                  icon: AppAssets.location,
                  onTap: () {},
                  title: "Location",
                ),
              ],
            ),
          );
        });
  }
}

class ChatRoomTextField extends StatelessWidget {
  final void Function()? onAttachment,
      onFiles,
      onCamera,
      onMicroPhone,
      onSend,
      onpickedFileCancel;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const ChatRoomTextField({
    super.key,
    this.onAttachment,
    this.onFiles,
    this.onCamera,
    this.onMicroPhone,
    this.controller,
    this.onChanged,
    this.onSend,
    this.onpickedFileCancel,
  });

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatRoomController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          chatController.pickedFile != null &&
                  MediaType.mediaType == MediaType.image
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(chatController.pickedFile!,
                          height: 35.h, width: 30.w, fit: BoxFit.cover),
                    ),
                    Positioned(
                        right: 0.w,
                        top: 0,
                        child: GestureDetector(
                          onTap: onpickedFileCancel,
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: 16,
                          ),
                        )),
                  ],
                )
              : chatController.thumbnail != null &&
                      MediaType.mediaType == MediaType.video
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(chatController.thumbnail!,
                              height: 35.h, width: 30.w, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 10.h,
                          left: 7.w,
                          child: const Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: AppColors.appBgColor,
                          ),
                        ),
                        Positioned(
                            right: 0.w,
                            top: 0,
                            child: GestureDetector(
                              onTap: onpickedFileCancel,
                              child: const Icon(
                                Icons.cancel_outlined,
                                size: 16,
                              ),
                            ))
                      ],
                    )
                  : chatController.files != null &&
                          MediaType.mediaType == MediaType.file
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SvgPicture.asset(AppAssets.docs,
                                  height: 35.h, width: 30.w, fit: BoxFit.cover),
                            ),
                            Positioned(
                                left: 0.w,
                                top: 0,
                                child: GestureDetector(
                                  onTap: onpickedFileCancel,
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    size: 16,
                                  ),
                                )),
                          ],
                        )
                      : GestureDetector(
                          onTap: onAttachment,
                          child: SvgPicture.asset(AppAssets.attachment)),
          const SizedBox(width: 10),
          Expanded(
              child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            style: AppTextStyle.circularFont12
                .copyWith(color: AppColors.blackColor),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                      onTap: onFiles, child: SvgPicture.asset(AppAssets.files)),
                ),
                hintText: "Write your message",
                hintStyle: AppTextStyle.circularFont12,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightBlue),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightBlue),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                filled: true,
                fillColor: AppColors.lightBlue),
          )),
          const SizedBox(width: 10),
          if (chatController.buttonDisable())
            GestureDetector(
                onTap: onCamera, child: SvgPicture.asset(AppAssets.camera)),
          if (chatController.buttonDisable()) const SizedBox(width: 10),
          if (chatController.buttonDisable())
            GestureDetector(
                onTap: onMicroPhone,
                child: SvgPicture.asset(AppAssets.microPhone)),
          if (!chatController.buttonDisable() && !chatController.isSending)
            GestureDetector(
                onTap: onSend, child: SvgPicture.asset(AppAssets.sendButton)),
          if (!chatController.buttonDisable() && chatController.isSending)
            const CircularProgressIndicator(color: AppColors.greenColor)
        ],
      ),
    );
  }
}
