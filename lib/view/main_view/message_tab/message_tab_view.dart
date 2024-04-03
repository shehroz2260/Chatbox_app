import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_controller.dart';
import '../../../utils/app_gap.dart';
import '../../../widgets/thread_widget.dart';

class MessageTabView extends StatelessWidget {
  const MessageTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageTabController());
    return GetBuilder<MessageTabController>(builder: (context) {
      return Column(
        mainAxisAlignment: controller.isLoading
            ? MainAxisAlignment.center
            : (!controller.isLoading && controller.messagesList.isEmpty)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children: [
          !controller.isLoading && controller.messagesList.isEmpty
              ? const Text("There is no threads")
              : controller.isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.greenColor,
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          AppGap.height40,
                          ...List.generate(
                            controller.messagesList.length,
                            (index) => ThreadWidget(
                              model: controller.messagesList[index],
                            ),
                          ),
                        ]),
                      ),
                    ),
        ],
      );
    });
  }
}
