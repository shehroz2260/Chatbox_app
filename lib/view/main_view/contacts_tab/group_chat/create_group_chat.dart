import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/view/main_view/contacts_tab/group_chat/create_group_chat_controller.dart';
import 'package:practice_project/view/main_view/contacts_tab/group_chat/create_group_info/create_group_info.dart';
import 'package:resize/resize.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_gap.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../widgets/app_cached_image.dart';
import '../../../../widgets/back_button.dart';

class CreateGroupChat extends StatelessWidget {
  final List<UserModel> contactList;
  const CreateGroupChat({super.key, required this.contactList});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateGroupController());
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.blackColor,
        child: GetBuilder<CreateGroupController>(builder: (context) {
          return Column(
            children: [
              AppGap.height60,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButtonWidget(
                      isBackWhite: false,
                    ),
                    Text(
                      "Create Group",
                      style: AppTextStyle.carosFont20,
                    ),
                    controller.participantID.length <= 1
                        ? SizedBox(width: 24.w)
                        : GestureDetector(
                            onTap: () {
                              Get.to(() => CreateGroupInfo(
                                    selectedUserList:
                                        controller.selectedUserList,
                                    idList: controller.participantID,
                                  ));
                            },
                            child: Icon(
                              Icons.check,
                              size: 24.sp,
                              color: AppColors.appBgColor,
                            ),
                          )
                  ],
                ),
              ),
              AppGap.height30,
              Expanded(
                child: Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      color: AppColors.appBgColor),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGap.height40,
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              contactList.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        controller.selectUser(
                                            contactList, index);
                                      },
                                      child: Row(
                                        children: [
                                          AppCacheImage(
                                            height: 52.h,
                                            width: 52.w,
                                            imageUrl:
                                                contactList[index].profile,
                                            round: 52,
                                          ),
                                          SizedBox(width: 10.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(contactList[index].name,
                                                  style:
                                                      AppTextStyle.carosFont18),
                                              Text(
                                                contactList[index].status,
                                                style:
                                                    AppTextStyle.circularFont12,
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          CheckBoxWidget(
                                            isSelect:
                                                contactList[index].isSelect,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class CheckBoxWidget extends StatelessWidget {
  final bool isSelect;
  const CheckBoxWidget({
    super.key,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          border: Border.all(
              color: isSelect ? AppColors.greenColor : AppColors.borderColor)),
      child: isSelect
          ? const Icon(
              Icons.check,
              size: 16,
              color: AppColors.greenColor,
            )
          : const SizedBox(),
    );
  }
}
