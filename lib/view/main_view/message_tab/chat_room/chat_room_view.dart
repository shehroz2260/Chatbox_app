import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:practice_project/models/thread_model.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/constants.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/view/main_view/message_tab/chat_room/chat_room_controller.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:practice_project/widgets/back_button.dart';
import 'package:practice_project/widgets/call_ui_widget.dart';
import 'package:resize/resize.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../widgets/message_box.dart';
import '../../../../widgets/model_bottom_widget.dart';

class ChatRoomView extends StatelessWidget {
  final UserModel model;
  final ThreadModel threadModel;
  final String threadId;
  const ChatRoomView({
    super.key,
    required this.model,
    required this.threadId,
    required this.threadModel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatRoomController(threadId));
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: GetBuilder<ChatRoomController>(builder: (context) {
        return Column(
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration:
                  const BoxDecoration(color: AppColors.appBgColor, boxShadow: [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(5, 0),
                  color: Color(0xff111222),
                ),
              ]),
              child: Column(
                children: [
                  AppGap.height60,
                  Row(
                    children: [
                      const BackButtonWidget(),
                      SizedBox(width: 10.w),
                      AppCacheImage(
                        imageUrl: threadModel.threadType == ThreadType.groupChat
                            ? threadModel.groupImage
                            : model.profile,
                        height: 44.h,
                        width: 44.w,
                        round: 44,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            threadModel.threadType == ThreadType.groupChat
                                ? threadModel.groupName
                                : model.name,
                            style: AppTextStyle.carosFont16
                                .copyWith(fontWeight: FontWeight.w500)
                                .copyWith(color: AppColors.blackColor),
                          ),
                          if (threadModel.threadType == ThreadType.oneToOneChat)
                            Text(model.isActive ? "Active Now" : "Offline",
                                style: AppTextStyle.circularFont12)
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                CallUIWidgte(name: model.name, uID: model.uid));
                          },
                          child: SvgPicture.asset(AppAssets.audioCall)),
                      SizedBox(width: 10.w),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => CallUIWidgte(
                                  name: model.name,
                                  uID: model.uid,
                                  videoCall: true,
                                ));
                          },
                          child: SvgPicture.asset(AppAssets.videoCall)),
                    ],
                  ),
                  AppGap.height16
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppGap.height16,
                    (!controller.isLoading && controller.messageList.isEmpty)
                        ? Padding(
                            padding: EdgeInsets.only(top: 300.h),
                            child: const Center(
                              child: Text("Enter your first message"),
                            ),
                          )
                        : (controller.isLoading &&
                                controller.messageList.isEmpty)
                            ? Padding(
                                padding: EdgeInsets.only(top: 300.h),
                                child: const CircularProgressIndicator(
                                  color: AppColors.greenColor,
                                ))
                            : ListView.builder(
                                controller: controller.scrollController,
                                padding: const EdgeInsets.only(top: 15),
                                shrinkWrap: true,
                                itemCount: controller.messageList.length,
                                reverse: true,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: [
                                      controller.isLoading && 0 == index
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Container(),
                                      MessageBox(
                                        profile: threadModel.threadType ==
                                                ThreadType.groupChat
                                            ? controller.messageList[index]
                                                    .profileImae ??
                                                ""
                                            : model.profile,
                                        onTap: () async {
                                          OpenAppFile.open(
                                              await controller.downloadFile(
                                                  controller.messageList[index]
                                                      .media!.url,
                                                  controller.messageList[index]
                                                      .media!.name));
                                        },
                                        index: index,
                                        isSender: controller
                                                .messageList[index].senderId ==
                                            Constant.userModel.uid,
                                        model: controller.messageList[index],
                                      )
                                    ],
                                  );
                                }),
                  ],
                ),
              ),
            ),
            AppGap.height16,
            ChatRoomTextField(
              onFiles: controller.pickFile,
              onpickedFileCancel: controller.clearPickedValue,
              onAttachment: CustomModelBottomSheet.modelBottomSheet,
              onCamera: () => controller.pickImage(false, false),
              onChanged: controller.onbuttonChanged,
              controller: controller.chatController,
              onSend: controller.isSending ? null : controller.sendMessage,
            ),
            AppGap.height30,
          ],
        );
      }),
    );
  }
}
