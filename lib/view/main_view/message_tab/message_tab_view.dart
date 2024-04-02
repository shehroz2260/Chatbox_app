import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_controller.dart';
import '../../../utils/app_gap.dart';
import '../../../widgets/thread_widget.dart';
import 'chat_room/chat_room_view.dart';

class MessageTabView extends StatelessWidget {
  const MessageTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageTabController());
    return Column(
      children: [
        AppGap.height40,
        Expanded(
          child: SingleChildScrollView(
            child: GetBuilder<MessageTabController>(builder: (context) {
              return Column(
                children: List.generate(
                    controller.messagesList.length,
                    (index) => ThreadWidget(
                          onDelete: () {
                            controller.deleteThread(
                                controller.messagesList[index].threadId);
                          },
                          onTap: () {
                            Get.to(() => ChatRoomView(
                                threadModel: controller.messagesList[index],
                                threadId:
                                    controller.messagesList[index].threadId,
                                model: controller
                                    .messagesList[index].userDetail!));
                          },
                          model: controller.messagesList[index],
                        )),
              );
            }),
          ),
        ),
      ],
    );
  }
}
