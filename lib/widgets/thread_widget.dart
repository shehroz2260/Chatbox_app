import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:practice_project/models/thread_model.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/view/main_view/message_tab/chat_room/chat_room_view.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_controller.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:resize/resize.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../controllers/admin_base_controller.dart';

class ThreadWidget extends StatelessWidget {
  final ThreadModel model;
  final bool isSearchView;
  const ThreadWidget({
    super.key,
    this.isSearchView = false,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      direction: Axis.horizontal,
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        if (!isSearchView)
          GestureDetector(
            onTap: () {
              Get.find<MessageTabController>().deleteThread(model.threadId);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.redColor,
              ),
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(AppAssets.deleteIcon),
            ),
          )
      ]),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () {
            Get.to(() =>
                ChatRoomView(model: model.userDetail!, threadModel: model));
          },
          child: Row(
            children: [
              AppCacheImage(
                imageUrl: model.threadType == ThreadType.groupChat
                    ? model.groupImage
                    : model.userDetail!.profile,
                height: 52.h,
                width: 52.w,
                round: 52,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.threadType == ThreadType.groupChat
                        ? model.groupName
                        : model.userDetail!.name,
                    style: AppTextStyle.carosFont20
                        .copyWith(color: AppColors.blackColor),
                  ),
                  Text(model.lastMessage, style: AppTextStyle.circularFont12)
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat("dd/MM/yyyy").format(model.lastMessageTime),
                    style: AppTextStyle.circularFont12
                        .copyWith(color: AppColors.blackColor),
                  ),
                  if (model.senderId != AdminBaseController.userData.uid &&
                      model.messageCount != 0)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.redColor),
                      alignment: Alignment.center,
                      child: Text(
                        model.messageCount.toString(),
                        style: AppTextStyle.circularFont12
                            .copyWith(color: AppColors.appBgColor),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
