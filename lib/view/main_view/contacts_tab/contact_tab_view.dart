import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/chat_services.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/utils/app_text_style.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/view/controllers/admin_base_controller.dart';
import 'package:practice_project/view/main_view/contacts_tab/contacts_tab_controller.dart';
import 'package:practice_project/view/main_view/message_tab/chat_room/chat_room_view.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_controller.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:resize/resize.dart';

class ContactTabView extends StatelessWidget {
  const ContactTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactTabController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGap.height40,
        Text(
          AppStrings.myContact,
          style: AppTextStyle.carosFont16.copyWith(fontWeight: FontWeight.w500),
        ),
        AppGap.height16,
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: controller.categorizedNames.length,
            itemBuilder: (context, index) {
              final letter = controller.categorizedNames.keys.elementAt(index);
              final namesForLetter = controller.categorizedNames[letter]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      letter,
                      style: AppTextStyle.carosFont16
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: namesForLetter.length,
                    itemBuilder: (context, index) {
                      final model = namesForLetter[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            ThreadType.threadType = ThreadType.oneToOneChat;
                            final id = ChatServices.createThreadId(
                                model.uid, AdminBaseController.userData.uid);
                            ChatServices.createNewThread(
                                    model,
                                    AdminBaseController.userData,
                                    null,
                                    [],
                                    "",
                                    null)
                                .then((value) {
                              Get.to(() => ChatRoomView(
                                    threadModel:
                                        Get.find<MessageTabController>()
                                            .messagesList[index],
                                    model: model,
                                    threadId: id,
                                  ));
                            });
                          },
                          child: Row(
                            children: [
                              AppCacheImage(
                                height: 52.h,
                                width: 52.w,
                                imageUrl: model.profile,
                                round: 52,
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.name,
                                      style: AppTextStyle.carosFont18),
                                  Text(
                                    model.status,
                                    style: AppTextStyle.circularFont12,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(),
          ),
        ),
      ],
    );
  }
}
